import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "dev.ogaroh.fake_store.dev"
            resValue(type = "string", name = "app_name", value = "FakeStore Dev")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "dev.ogaroh.fake_store"
            resValue(type = "string", name = "app_name", value = "FakeStore")
        }
    }
}