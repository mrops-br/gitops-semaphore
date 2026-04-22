{{/*
Expand the name of the chart.
*/}}
{{- define "semaphore-ui.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "semaphore-ui.fullname" -}}
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
Create chart label.
*/}}
{{- define "semaphore-ui.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "semaphore-ui.labels" -}}
helm.sh/chart: {{ include "semaphore-ui.chart" . }}
{{ include "semaphore-ui.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "semaphore-ui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "semaphore-ui.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Semaphore-specific labels
*/}}
{{- define "semaphore-ui.semaphore.labels" -}}
{{ include "semaphore-ui.labels" . }}
app.kubernetes.io/component: semaphore
{{- end }}

{{- define "semaphore-ui.semaphore.selectorLabels" -}}
{{ include "semaphore-ui.selectorLabels" . }}
app.kubernetes.io/component: semaphore
{{- end }}

{{/*
Nginx-specific labels
*/}}
{{- define "semaphore-ui.nginx.labels" -}}
{{ include "semaphore-ui.labels" . }}
app.kubernetes.io/component: nginx
{{- end }}

{{- define "semaphore-ui.nginx.selectorLabels" -}}
{{ include "semaphore-ui.selectorLabels" . }}
app.kubernetes.io/component: nginx
{{- end }}

{{/*
Service account name
*/}}
{{- define "semaphore-ui.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "semaphore-ui.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Semaphore service name
*/}}
{{- define "semaphore-ui.semaphore.serviceName" -}}
{{- printf "%s-semaphore" (include "semaphore-ui.fullname" .) }}
{{- end }}

{{/*
Nginx service name
*/}}
{{- define "semaphore-ui.nginx.serviceName" -}}
{{- printf "%s-nginx" (include "semaphore-ui.fullname" .) }}
{{- end }}
