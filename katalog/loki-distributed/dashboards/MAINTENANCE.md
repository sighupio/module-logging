# Loki Dashboards maintenance

The dashboards in this project are copied over from [Loki mixins](https://github.com/grafana/loki/tree/main/production/loki-mixin-compiled) and customized to fit our way of deploying Loki.

## Customizations

Just update the Loki version in [mise.toml](./mise.toml) and run from this dir:

```bash
mise run download_mixins
```
