package com.mofa.ksa

import android.content.Context
import android.os.Bundle
import android.util.Log
import com.airwatch.sdk.profile.AnchorAppStatus
import com.airwatch.sdk.profile.ApplicationProfile
import com.airwatch.sdk.shareddevice.ClearReasonCode
import com.airwatch.event.WS1AnchorEvents

class WS1EventImpl : WS1AnchorEvents {
    override fun onApplicationConfigurationChange(bundle: Bundle?, context: Context) {
        Log.d("WS1_SDK", "Application configuration changed")
    }

    override fun onApplicationProfileReceived(
        context: Context,
        profileId: String,
        applicationProfile: ApplicationProfile
    ) {
        Log.d("WS1_SDK", "Application Profile Received: $profileId")
    }

    override fun onClearAppDataCommandReceived(
        context: Context,
        clearReasonCode: ClearReasonCode
    ) {
        Log.d("WS1_SDK", "Clear App Data Command Received. Reason: $clearReasonCode")
    }

    override fun onAnchorAppStatusReceived(
        context: Context,
        anchorAppStatus: AnchorAppStatus
    ) {
        Log.d("WS1_SDK", "Anchor App Status: $anchorAppStatus")
    }

    override fun onAnchorAppUpgrade(context: Context, isUpgraded: Boolean) {
        Log.d("WS1_SDK", "Anchor App Upgrade: $isUpgraded")
    }
}
