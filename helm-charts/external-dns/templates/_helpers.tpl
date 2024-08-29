{{/*
Expand the name of the chart.
*/}}
{{- define "external-dns.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "external-dns.fullname" -}}
{{- printf "%s-%s" (include "external-dns.name" .) .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end }}
