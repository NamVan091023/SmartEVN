package com.app.pollution_environment

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.view.FlutterMain
import rekab.app.background_locator.IsolateHolderService
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin

class Application : FlutterApplication(), PluginRegistrantCallback {

    override fun onCreate() {
        FlutterMain.startInitialization(this)
        super.onCreate()
        // IsolateHolderService.setPluginRegistrant(this)
        // GeneratedPluginRegistrant.registerWith(this)

    }
    override fun registerWith(registry: PluginRegistry?) {
       if (!registry!!.hasPlugin("io.flutter.plugins.sharedpreferences")) {
            SharedPreferencesPlugin.registerWith(registry!!.registrarFor("io.flutter.plugins.sharedpreferences"))
        }
    }
}