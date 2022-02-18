package com.planetoliver.appclientes

import android.os.AsyncTask
import androidx.annotation.NonNull
//import com.kushkipagos.android.Card
//import com.kushkipagos.android.Kushki
//import com.kushkipagos.android.KushkiEnvironment
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.lang.Exception

class MainActivity : FlutterActivity() {
    private val CHANNEL = "kushki.payment/channel"
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            val argData = call.arguments

            if (call.method == "gen_token") {
                val batteryLevel = genToken(argData as Map<String, String>)

                if (batteryLevel != "") {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else if (call.method == "async_token") {
                val batteryLevel2 = genSubsToken(argData as Map<String, String>)

                if (batteryLevel2 != "") {
                    result.success(batteryLevel2)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else
                result.notImplemented()
            }
        }

//    internal inner class kushkiToken : AsyncTask<Map<String, String>, Void, String>() {
//
//        override fun doInBackground(vararg p0: Map<String, String>): String {
//            try {
//                val data = p0[0]
//
//                val name: String = data["name"] as String
//                val number: String = data["number"] as String
////                val number: String = "4539027568773860"
//                val ccv: String = data["ccv"] as String
//                val month: String = data["month"] as String
//                val year: String = data["year"] as String
//                val card = Card(name, number, ccv, month, year); // add card properties
////                val card = Card("name","4539027568773860","123","09","21") //add card properties
//                val totalAmount: Double = data["totalAmount"].toString().toDouble()
//                val publicMerchantId = "10000002667885476032150186346335"
//
//                val kushki = Kushki(publicMerchantId,
//                        "USD",
//                        KushkiEnvironment.TESTING,
//                        false)
//
//                return kushki.requestToken(card, totalAmount).token
//            }catch(kushkiException: Exception){
//                return "no token";
//            }
//        }
//    }

//    internal inner class kushkiSubsToken : AsyncTask<Map<String, String>, Void, String>() {
//
//        override fun doInBackground(vararg p0: Map<String, String>): String {
//
//            val data = p0[0]
//
//            val name: String = data["name"] as String
//            val number: String = data["number"] as String
//            val ccv: String = data["ccv"] as String
//            val month: String = data["month"] as String
//            val year: String = data["year"] as String
//            val card = Card(name, number, ccv, month, year); // add card properties
//            val publicMerchantId = "10000002667885476032150186346335"
//
//            val kushki = Kushki(publicMerchantId,
//                    "USD",
//                    KushkiEnvironment.TESTING,
//                    false)
//
//            return kushki.requestSubscriptionToken(card).token
//        }
//    }

    fun genToken(data: Map<String, String>): String? {
//        return kushkiToken().execute(data).get()
        return "98765432123";
    }

    private fun genSubsToken(data: Map<String, String>): String? {
//        val myVal = kushkiSubsToken().execute(data)
        return "98765432123";
    }
}
