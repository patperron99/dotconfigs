#!/bin/bash

# Set the threshold for available disk space (in percentage)
THRESHOLD=30

# Get the available disk space on the root filesystem
AVAILABLE_ROOT=$(df / --output=pcent | tail -1 | tr -dc '0-9')

is_manager(){
    role=$(docker node inspect self --format "{{ .Spec.Role }}")
    if [ "$role" == "manager" ]; then
        echo 1
    else
        echo 0
    fi
}

clean_registry() {
    if [ -d "/qaRegistry" ]; then
        AVAILABLE_REGISTRY=$(df /qaRegistry --output=pcent | tail -1 | tr -dc '0-9')
        if [ "$AVAILABLE_REGISTRY" -ge $((100 - THRESHOLD)) ]; then
            docker exec -t $(docker ps --format '{{.Names}}' | grep registry) registry garbage-collect /etc/docker/registry/config.yml -m
        fi
    fi
}

clean_docker() {
    if [ ! $(hash docker) ]; then
        echo "Cleaning docker stuff..."
        docker image prune -af
        docker volume prune -af
        docker system prune -af
    fi
}


# Check if available space is less than the threshold
clean_root() {
    if [ "$AVAILABLE_ROOT" -ge $((100 - THRESHOLD)) ]; then
        echo "Disk space is low: ${AVAILABLE_ROOT}% used. Starting cleanup..."

        # Example: Remove old log files in /var/log
        find /var/log -type f -name "*.gz" -exec rm -f {} \;

        # Clear apt cache
        apt-get clean
        clean_docker
        echo "Root / cleanup completed."
    else
        echo "Disk space is sufficient: ${AVAILABLE_ROOT}% used on Root /. No action needed."
    fi
}

clean_workers() {
    echo "Cleaning workers..."
    for worker in ${qa_workers[@]}
    do
        scp -i ~/.ssh/qa-workers.pem /usr/local/bin/disk_space_monitor.sh admin@${qa_workers}:/usr/local/bin/
        ssh -i ~/.ssh/qa-workers.pem admin@${qa_workers} sudo bash /usr/local/bin/disk_space_monitor.sh
    done
}

qa_workers=($(docker node ls --format "{{.Hostname}}" --filter role=worker))

if is_manager; then
    clean_workers
fi

clean_root
clean_registry
