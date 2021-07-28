//
//  Generated file. Do not edit.
//

#include "generated_plugin_registrant.h"

#include <virtual_controller/virtual_controller_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) virtual_controller_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "VirtualControllerPlugin");
  virtual_controller_plugin_register_with_registrar(virtual_controller_registrar);
}
