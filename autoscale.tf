resource "azurerm_resource_group" "jaerg" {
  name     = "jaerg"
  location = "West US"
}

resource "azurerm_virtual_network" "jaerg" {
  name                = "acctvn"
  address_space       = ["10.86.0.0/16"]
  location            = azurerm_resource_group.jaerg.location
  resource_group_name = azurerm_resource_group.jaerg.name
}

resource "azurerm_subnet" "public-1" {
  name                 = "acctsub"
  resource_group_name  = azurerm_resource_group.jaerg.name
  virtual_network_name = azurerm_virtual_network.jaerg.name
  address_prefixes     = ["10.86.1.0/24"]
}

resource "azurerm_subnet" "public-2" {
  name                 = "acctsub"
  resource_group_name  = azurerm_resource_group.jaerg.name
  virtual_network_name = azurerm_virtual_network.jaerg.name
  address_prefixes     = ["10.86.2.0/24"]
}

resource "azurerm_subnet" "public-3" {
  name                 = "acctsub"
  resource_group_name  = azurerm_resource_group.jaerg.name
  virtual_network_name = azurerm_virtual_network.jaerg.name
  address_prefixes     = ["10.86.3.0/24"]
}

resource "azurerm_subnet" "private-1" {
  name                 = "acctsub"
  resource_group_name  = azurerm_resource_group.jaerg.name
  virtual_network_name = azurerm_virtual_network.jaerg.name
  address_prefixes     = ["10.86.11.0/24"]
}

resource "azurerm_subnet" "private-2" {
  name                 = "acctsub"
  resource_group_name  = azurerm_resource_group.jaerg.name
  virtual_network_name = azurerm_virtual_network.jaerg.name
  address_prefixes     = ["10.86.12.0/24"]
}

resource "azurerm_subnet" "private-3" {
  name                 = "acctsub"
  resource_group_name  = azurerm_resource_group.jaerg.name
  virtual_network_name = azurerm_virtual_network.jaerg.name
  address_prefixes     = ["10.86.13.0/24"]
}

resource "azurerm_linux_virtual_machine_scale_set" "jaerg" {
  name                = "jaerg"
  location            = azurerm_resource_group.jaerg.location
  resource_group_name = azurerm_resource_group.jaerg.name
  upgrade_mode        = "Manual"
  sku                 = "Standard_F2"
  instances           = 1
  admin_username      = "josh"

  admin_ssh_key {
    username   = "josh"
    public_key = var.public_key
  }

  network_interface {
    name    = "TestNetworkProfile"
    primary = true

    ip_configuration {
      name      = "TestIPConfiguration"
      primary   = true
      subnet_id = azurerm_subnet.public-1.id
    }
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  lifecycle {
    ignore_changes = [instances]
  }
}

resource "azurerm_monitor_autoscale_setting" "jaerg" {
  name                = "myAutoscaleSetting"
  resource_group_name = azurerm_resource_group.jaerg.name
  location            = azurerm_resource_group.jaerg.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.jaerg.id

  profile {
    name = "defaultProfile"

    capacity {
      default = 6
      minimum = 3
      maximum = 10
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.jaerg.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
        dimensions {
          name     = "AppName"
          operator = "Equals"
          values   = ["App1"]
        }
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.jaerg.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }

  predictive {
    scale_mode      = "Enabled"
    look_ahead_time = "PT5M"
  }

  notification {
    email {
      send_to_subscription_administrator    = true
      send_to_subscription_co_administrator = true
      custom_emails                         = ["josh_7_86@yahoo.com"]
    }
  }
}