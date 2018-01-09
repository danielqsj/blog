+++
title = "Kafka Exporter v1.0.0 Release"
disqusIdentifier = "Kafka exporter v1.0.0 release"
date = "2018-01-09T14:40:36+08:00"
categories = ["project"]
tags = ["kafka-exporter"]
series = ["project"]
comments = true
keywords = ["kafka-exporter"]
showDate = true
showPagination = true
showSocial = true
showTags = true
+++

kakfa exporter v1.0.0于今日正式发布，Prometheus官方推荐，新增多项特性，欢迎大家使用，多提宝贵意见。
# 项目地址
Github: https://github.com/danielqsj/kafka_exporter
Docker Hub: https://hub.docker.com/r/danielqsj/kafka-exporter
# 项目状态
自v0.2.0版本被Prometheus项目官方[推荐](https://prometheus.io/docs/instrumenting/exporters/#messaging-systems)以来，[镜像](https://hub.docker.com/r/danielqsj/kafka-exporter/)累计下载量已超过6.1k，已经稳定运行在多个平台。
## 特点
kafka exporter 通过 [Kafka Protocol Specification](https://cwiki.apache.org/confluence/display/KAFKA/A+Guide+To+The+Kafka+Protocol) 收集 Brokers, Topics 以及 Consumer Groups的相关指标，使用简单，运行高效，相比于以往通过kafka内置的脚本进行收集，由于没有了JVM的运行开销，指标收集时间从分钟级别降到秒级别，便于大规模集群的监控。
## 使用方法
详见项目[说明文档](https://github.com/danielqsj/kafka_exporter/blob/master/README.md)。
## 指标
### Brokers
**Metrics details**

| Name            | Exposed informations                   |
| --------------- | -------------------------------------- |
| `kafka_brokers` | Number of Brokers in the Kafka Cluster |

**Metrics output example**

```txt
# HELP kafka_brokers Number of Brokers in the Kafka Cluster.
# TYPE kafka_brokers gauge
kafka_brokers 3
```

### Topics

**Metrics details**

| Name                                               | Exposed informations                                |
| -------------------------------------------------- | --------------------------------------------------- |
| `kafka_topic_partitions`                           | Number of partitions for this Topic                 |
| `kafka_topic_partition_current_offset`             | Current Offset of a Broker at Topic/Partition       |
| `kafka_topic_partition_oldest_offset`              | Oldest Offset of a Broker at Topic/Partition        |
| `kafka_topic_partition_in_sync_replica`            | Number of In-Sync Replicas for this Topic/Partition |
| `kafka_topic_partition_leader`                     | Leader Broker ID of this Topic/Partition            |
| `kafka_topic_partition_leader_is_preferred`        | 1 if Topic/Partition is using the Preferred Broker  |
| `kafka_topic_partition_replicas`                   | Number of Replicas for this Topic/Partition         |
| `kafka_topic_partition_under_replicated_partition` | 1 if Topic/Partition is under Replicated            |

**Metrics output example**

```txt
# HELP kafka_topic_partitions Number of partitions for this Topic
# TYPE kafka_topic_partitions gauge
kafka_topic_partitions{topic="__consumer_offsets"} 50

# HELP kafka_topic_partition_current_offset Current Offset of a Broker at Topic/Partition
# TYPE kafka_topic_partition_current_offset gauge
kafka_topic_partition_current_offset{partition="0",topic="__consumer_offsets"} 0

# HELP kafka_topic_partition_oldest_offset Oldest Offset of a Broker at Topic/Partition
# TYPE kafka_topic_partition_oldest_offset gauge
kafka_topic_partition_oldest_offset{partition="0",topic="__consumer_offsets"} 0

# HELP kafka_topic_partition_in_sync_replica Number of In-Sync Replicas for this Topic/Partition
# TYPE kafka_topic_partition_in_sync_replica gauge
kafka_topic_partition_in_sync_replica{partition="0",topic="__consumer_offsets"} 3

# HELP kafka_topic_partition_leader Leader Broker ID of this Topic/Partition
# TYPE kafka_topic_partition_leader gauge
kafka_topic_partition_leader{partition="0",topic="__consumer_offsets"} 0

# HELP kafka_topic_partition_leader_is_preferred 1 if Topic/Partition is using the Preferred Broker
# TYPE kafka_topic_partition_leader_is_preferred gauge
kafka_topic_partition_leader_is_preferred{partition="0",topic="__consumer_offsets"} 1

# HELP kafka_topic_partition_replicas Number of Replicas for this Topic/Partition
# TYPE kafka_topic_partition_replicas gauge
kafka_topic_partition_replicas{partition="0",topic="__consumer_offsets"} 3

# HELP kafka_topic_partition_under_replicated_partition 1 if Topic/Partition is under Replicated
# TYPE kafka_topic_partition_under_replicated_partition gauge
kafka_topic_partition_under_replicated_partition{partition="0",topic="__consumer_offsets"} 0
```

### Consumer Groups

**Metrics details**

| Name                                 | Exposed informations                                          |
| ------------------------------------ | ------------------------------------------------------------- |
| `kafka_consumergroup_current_offset` | Current Offset of a ConsumerGroup at Topic/Partition          |
| `kafka_consumergroup_lag`            | Current Approximate Lag of a ConsumerGroup at Topic/Partition |

**Metrics output example**

```txt
# HELP kafka_consumergroup_current_offset Current Offset of a ConsumerGroup at Topic/Partition
# TYPE kafka_consumergroup_current_offset gauge
kafka_consumergroup_current_offset{consumergroup="KMOffsetCache-kafka-manager-3806276532-ml44w",partition="0",topic="__consumer_offsets"} -1

# HELP kafka_consumergroup_lag Current Approximate Lag of a ConsumerGroup at Topic/Partition
# TYPE kafka_consumergroup_lag gauge
kafka_consumergroup_lag{consumergroup="KMOffsetCache-kafka-manager-3806276532-ml44w",partition="0",topic="__consumer_offsets"} 1
```
## Release Notes
### v1.0.0
* [FEATURE] Support TLS
* [FEATURE] Support disable SASL handshake
* [FEATURE] Support enable Sarama logging for detailed connection management events
* [ENHANCEMENT] Provide specific string for Kafka logging, debugging, and auditing purposes
* [BUGFIX] Fix multiple prometheus servers scraping competition issue
* [BUGFIX] Fix overwrite configuration issue
### v0.3.0
* [FEATURE] Support kafka SASL/PLAIN authentication
* [FEATURE] Support topic filter
* [BUGFIX] Fix topics not sync when modifying topic list
### v0.2.0
* [CHANGE] Change default port to 9308
* [ENHANCEMENT] Support multiple addresses for kafka servers
### v0.1.0
* Initial release