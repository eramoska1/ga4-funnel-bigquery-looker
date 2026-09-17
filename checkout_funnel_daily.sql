# Evelina Ramoskaite
# GA4 BigQuery Funnel Data Pull
# Source: Google Analytics 4 sample ecommerce dataset
# Hosted in BigQuery public dataset (bigquery-public-data.ga4_obfuscated_sample_ecommerce)
# Date Range: January 2021
SELECT 
  event_date,
  event_name,
  user_pseudo_id,
  (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS session_id,
  timestamp_micros(event_timestamp) AS event_ts,
  geo.country AS country,
  geo.region AS state,
  device.category AS device_category,
  traffic_source.medium AS traffic_medium,
  traffic_source.source AS traffic_source,
  ecommerce.transaction_id AS transaction_id,
  ecommerce.purchase_revenue AS revenue
FROM 
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE 
  _TABLE_SUFFIX BETWEEN '{start_date}' AND '{end_date}'
  AND event_name IN ('session_start', 'view_item', 'add_to_cart', 'begin_checkout','add_shipping_info','add_payment_info','purchase')
