
{{/*
Create a default port for redis.
*/}}

{{- define "bjs_redis.port" -}}
{{- .Values.redis_port | default 6349 }}
{{- end }}

{{- define "bjs_redis.header" -}}
namespace: {{ .Release.Namespace }}
name: redis-{{ .Release.Name }}
labels:
  app: redis-{{ .Release.Name }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "bjs_redis.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "bjs_redis.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "bjs_redis.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "bjs_redis.labels" -}}
helm.sh/chart: {{ include "bjs_redis.chart" . }}
{{ include "bjs_redis.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "bjs_redis.selectorLabels" -}}
app.kubernetes.io/name: {{ include "bjs_redis.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "bjs_redis.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "bjs_redis.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
