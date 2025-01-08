#!/bin/bash

# Set the threshold for available disk space (in percentage)
THRESHOLD=30

# Get the available disk space on the root filesystem
AVAILABLE_ROOT=$(df / --output=pcent | tail -1 | tr -dc '0-9')
qa_workers=()

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
        echo "Connecting to ${worker}..."
        ssh -o "StrictHostKeyChecking=accept-new" -i ~/.ssh/qa-workers.pem admin@${worker} sudo bash -s < /usr/local/bin/disk_space_monitor.sh
        echo "Done."
    done
}

if $(docker info 2>/dev/null | grep -qi "is manager: true"); then
    echo "Is a manager"
    qa_workers=($(docker node ls --format "{{.Hostname}}" --filter role=worker))
    clean_workers
    #ssh -i ~/.ssh/qa-workers.pem admin@ip-172-16-2-16 bash -s < ~/test.sh
else
    echo "It is not!"
fi


clean_root
clean_registry
