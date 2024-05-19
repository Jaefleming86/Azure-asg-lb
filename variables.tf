variable "public_key" {
  default = (public_key)
}

variable "resource_group_name" {
  default = "jaerg"
}

variable "virtual_network_name" {
  default = "acctvn"
}

variable "subnet_name" {
  default = "acctsub"
}

variable "subnet_address_prefixes" {
  default = ["10.86.0.0/16"]
}

variable "subnet_private_address_prefixes" {
  default = ["10.86.11.0/24", "10.86.12.0/24", "10.86.13.0/24"]
}

variable "subnet_public_address_prefixes" {
  default = ["10.86.1.0/24", "10.86.2.0/24", "10.86.3.0/24"]
}

variable "vm_scale_set_name" {
  default = "jaerg"
}

variable "vm_scale_set_location" {
  default = "West US"
}

variable "vm_scale_set_sku" {
  default = "Standard_F2"
}

variable "vm_scale_set_instances" {
  default = 1
}

variable "vm_scale_set_admin_username" {
  default = "josh"
}

variable "vm_scale_set_admin_ssh_key_username" {
  default = "josh"
}

variable "vm_scale_set_os_disk_caching" {
  default = "ReadWrite"
}

variable "vm_scale_set_os_disk_storage_account_type" {
  default = "StandardSSD_LRS"
}

variable "vm_scale_set_image_publisher" {
  default = "Canonical"
}

variable "vm_scale_set_image_offer" {
  default = "0001-com-ubuntu-server-jammy"
}

variable "vm_scale_set_image_sku" {
  default = "22_04-lts"
}

variable "vm_scale_set_image_version" {
  default = "latest"
}

variable "autoscale_setting_name" {
  default = "myAutoscaleSetting"
}

variable "autoscale_setting_capacity_default" {
  default = 6
}

variable "autoscale_setting_capacity_minimum" {
  default = 3
}

variable "autoscale_setting_capacity_maximum" {
  default = 10
}

variable "autoscale_setting_metric_name" {
  default = "Percentage CPU"
}

variable "autoscale_setting_metric_time_grain" {
  default = "PT1M"
}

variable "autoscale_setting_metric_statistic" {
  default = "Average"
}

variable "autoscale_setting_metric_time_window" {
  default = "PT5M"
}

variable "autoscale_setting_metric_time_aggregation" {
  default = "Average"
}

variable "autoscale_setting_metric_operator_greater_than_threshold" {
  default = 75
}

variable "autoscale_setting_metric_operator_less_than_threshold" {
  default = 25
}

variable "autoscale_setting_metric_namespace" {
  default = "microsoft.compute/virtualmachinescalesets"
}

variable "autoscale_setting_metric_dimension_name" {
  default = "AppName"
}

variable "autoscale_setting_metric_dimension_operator" {
  default = "Equals"
}

variable "autoscale_setting_metric_dimension_values" {
  default = ["App1"]
}

variable "autoscale_setting_scale_action_direction_increase" {
  default = "Increase"
}

variable "autoscale_setting_scale_action_direction_decrease" {
  default = "Decrease"
}

variable "autoscale_setting_scale_action_type" {
  default = "ChangeCount"
}

variable "autoscale_setting_scale_action_value" {
  default = "1"
}

variable "autoscale_setting_scale_action_cooldown" {
  default = "PT1M"
}

variable "autoscale_setting_predictive_scale_mode" {
  default = "Enabled"
}

variable "autoscale_setting_predictive_look_ahead_time" {
  default = "PT5M"
}

variable "autoscale_setting_notification_email_send_to_subscription_administrator" {
  default = true
}

variable "autoscale_setting_notification_email_send_to_subscription_co_administrator" {
  default = true
}

variable "autoscale_setting_notification_email_custom_emails" {
  default = ["josh_7_86@yahoo.com"]
}
