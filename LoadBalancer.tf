resource "azurerm_public_ip" "jaerg" {
  name                = "PublicIPForLB"
  location            = azurerm_resource_group.jaerg.location
  resource_group_name = azurerm_resource_group.jaerg.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "jaerg" {
  name                = "LoadBalancer"
  location            = azurerm_resource_group.jaerg.location
  resource_group_name = azurerm_resource_group.jaerg.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.jaerg.id
  }
}

resource "azurerm_network_security_group" "jaerg" {
  name                = "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.jaerg.location
  resource_group_name = azurerm_resource_group.jaerg.name
}

resource "azurerm_network_security_rule" "jaerg" {
  name                        = "jaesg"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.jaerg.name
  network_security_group_name = azurerm_network_security_group.jaerg.name
}