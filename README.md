# Logagent

Container with Sematext [Logagent](https://github.com/sematext/logagent-js).

## Configuration

The container can be configured through the following environment variables:
* **LOG_URL**: The URL of your Elasticsearch Endpoint. _(defaults to: https://logsene-receiver.eu.sematext.com)_
* **LOG_INDEX**: The index where the agent should log to. _(For sematext users the app id.)_
* **LOG_GLOB**: Semicolon-separated list of file globs. _(e.g. /var/log/**/*.log;/my/app/logs/*.log)_
* **LA_ARGUMENTS**: Additional [command line arguments for Logagent](https://sematext.com/docs/logagent/cli-parameters/) e.g. LA_ARGUMENTS="-n httpd" to specify a log source name or LA_ARGUMENTS="-u 514" to act as syslog server.  

## Usage

1. Prepare your settings
2. Bind the container with volumes_from to another container from which you want the logs.
3. **Profit!**
