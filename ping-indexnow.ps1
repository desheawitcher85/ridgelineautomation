$key = "ed4c856a6a9a4310bb67bc08931c35e6"
$host_domain = "ridgelineautomation.io"

$urls = @(
  "https://ridgelineautomation.io/",
  "https://ridgelineautomation.io/about/",
  "https://ridgelineautomation.io/free-discovery-call/",
  "https://ridgelineautomation.io/owner-path/",
  "https://ridgelineautomation.io/ops-path/",
  "https://ridgelineautomation.io/blog/",
  "https://ridgelineautomation.io/blog/automation-insights-coming-to-roanoke/",
  "https://ridgelineautomation.io/services/discovery-audit/",
  "https://ridgelineautomation.io/services/automation-build/",
  "https://ridgelineautomation.io/services/maintenance-retainer/",
  "https://ridgelineautomation.io/roanoke/",
  "https://ridgelineautomation.io/roanoke/healthcare/",
  "https://ridgelineautomation.io/salem/",
  "https://ridgelineautomation.io/salem/manufacturing/",
  "https://ridgelineautomation.io/blacksburg/",
  "https://ridgelineautomation.io/blacksburg/startups/",
  "https://ridgelineautomation.io/christiansburg/",
  "https://ridgelineautomation.io/vinton/",
  "https://ridgelineautomation.io/lynchburg/",
  "https://ridgelineautomation.io/lynchburg/healthcare/"
)

$body = @{
  host    = $host_domain
  key     = $key
  keyLocation = "https://$host_domain/$key.txt"
  urlList = $urls
} | ConvertTo-Json

$endpoints = @(
  "https://api.indexnow.org/indexnow",
  "https://www.bing.com/indexnow",
  "https://search.seznam.cz/indexnow"
)

foreach ($endpoint in $endpoints) {
  try {
    $response = Invoke-RestMethod -Uri $endpoint -Method Post -Body $body -ContentType "application/json"
    Write-Host "OK: $endpoint"
  } catch {
    Write-Host "FAIL: $endpoint — $($_.Exception.Message)"
  }
}

Write-Host "`nDone. $($urls.Count) URLs submitted."
