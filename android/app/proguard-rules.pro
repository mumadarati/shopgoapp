# Preserve annotated Javascript interface methods.

-keepclassmembers class * {
    #noinspection ShrinkerUnresolvedReference
    @android.webkit.JavascriptInterface <methods>;
}