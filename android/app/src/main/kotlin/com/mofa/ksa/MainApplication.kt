package com.mofa.ksa

import android.content.Context
import android.content.Intent
import com.workspaceone_sdk_flutter.WorkspaceOneSdkApplication

class MainApplication : WorkspaceOneSdkApplication() {

    override fun onPostCreate() {
        super.onPostCreate()
        // Initialization code after SDK security checks pass
    }

    override fun attachBaseContext(base: Context?) {
        super.attachBaseContext(base)
        attachBaseContext(this)
    }

    override fun getMainActivityIntent(): Intent {
        return Intent(this, MainActivity::class.java)
    }
}
