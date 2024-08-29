{{/*
Expand the name of the chart.
*/}}
{{- define "ingress.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "ingress.fullname" -}}
{{- printf "%s-%s" (include "ingress.name" .) .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end }}
