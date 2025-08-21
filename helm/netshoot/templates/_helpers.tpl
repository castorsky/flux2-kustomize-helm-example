{{/*
Expand the name of the chart.
*/}}
{{- define "netshoot.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "netshoot.fullname" -}}
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
{{- define "netshoot.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "netshoot.labels" -}}
helm.sh/chart: {{ include "netshoot.chart" . }}
{{ include "netshoot.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "netshoot.hostLabels" -}}
helm.sh/chart: {{ include "netshoot.chart" . }}
{{ include "netshoot.hostSelectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "netshoot.selectorLabels" -}}
app.kubernetes.io/name: {{ include "netshoot.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
networking.apecloud.com/host-network: "false"
{{- end }}

{{- define "netshoot.hostSelectorLabels" -}}
app.kubernetes.io/name: {{ include "netshoot.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
networking.apecloud.com/host-network: "false"
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "netshoot.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "netshoot.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
