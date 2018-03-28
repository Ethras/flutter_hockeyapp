package com.ethras.flutterhockeyapp

import android.util.Log
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.PluginRegistry.Registrar
import net.hockeyapp.android.CrashManager
import net.hockeyapp.android.FeedbackManager
import net.hockeyapp.android.UpdateManager
import net.hockeyapp.android.UpdateManagerListener
import net.hockeyapp.android.metrics.MetricsManager

class FlutterHockeyappPlugin(private val registrar: Registrar) : MethodCallHandler {
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar): Unit {
            val channel = MethodChannel(registrar.messenger(), "flutter_hockeyapp")
            channel.setMethodCallHandler(FlutterHockeyappPlugin(registrar))
        }
    }

    private var _initialized: Boolean = false
    private var _token: String = ""

    override fun onMethodCall(call: MethodCall, result: Result): Unit {
        when (call.method) {
            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
            "start" -> {
                Log.i("HockeyApp", "Starting HockeyApp SDK...")
                start()
                result.success(true)
            }
            "configure" -> {
                Log.i("HockeyApp", "Configuring HockeyApp SDK...")
                configure(call.argument("token"))
                result.success(true)
            }
            "showFeedback" -> {
                Log.i("HockeyApp", "Showing feedback")
                showFeedback()
                result.success(true)
            }
            "checkForUpdates" -> {
                Log.i("HockeyApp", "Checking for updates...")
                checkForUpdates()
                result.success(true)
            }
            "trackEvent" -> {
                val eventName = call.argument<String>("eventName")
                Log.i("HockeyApp", eventName)
                trackEvent(eventName)
                result.success(true)
            }
            else -> result.notImplemented()
        }
    }

    private fun trackEvent(eventName: String) {
        MetricsManager.trackEvent(eventName);
    }

    private fun configure(token: String) {
        _token = token
        _initialized = true
    }

    private fun start() {
        if (_initialized) {
            FeedbackManager.register(registrar.context(), _token)
            CrashManager.register(registrar.context(), _token)
            MetricsManager.register(registrar.activity().application, _token)

            MetricsManager.trackEvent("HockeyApp SDK configured successfully");
        } else Log.e("HockeyApp", "HockeyApp not initialized")
    }

    private fun checkForUpdates() {
        if (_initialized) {
            UpdateManager.register(registrar.activity(), _token, _UpdateListener())
        } else Log.e("HockeyApp", "HockeyApp not initialized")

    }

    private fun showFeedback() {
        FeedbackManager.showFeedbackActivity(registrar.activity())
    }

    // Custom update listener
    class _UpdateListener : UpdateManagerListener() {
        override fun onNoUpdateAvailable() {
            super.onNoUpdateAvailable()
            Log.i("HockeyApp", "No update available")
        }
    }


}
