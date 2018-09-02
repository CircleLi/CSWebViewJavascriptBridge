(function(window){
    if(window.jsCommonHandler){
        return;
    }
    var CSJSCommonHandler = function(){
    };

    CSJSCommonHandler.prototype = jsBridge;

    CSJSCommonHandler.prototype.getUserInfo = function(callback){
        var msg = {};
        msg.handler = 'common';
        msg.action = 'getUserinfo';
        jsCommonHandler.webCallNative(msg, callback);
    }

    CSJSCommonHandler.prototype.getDeviceInfo = function(callback){
        var msg = {};
        msg.handler = 'common';
        msg.action = 'getDeviceInfo';
        jsCommonHandler.webCallNative(msg, callback);
    }

    CSJSCommonHandler.prototype.getLocationInfo = function(callback){
        var msg = {};
        msg.handler = 'common';
        msg.action = 'getLocationInfo';
        jsCommonHandler.webCallNative(msg, callback);
    }

    CSJSCommonHandler.prototype.share = function(callback){
        var msg = {};
        msg.handler = 'common';
        msg.action = 'share';
        jsCommonHandler.webCallNative(msg, callback);
    }

    var CSJSNativeEvent = function(){
        this.webViewWillAppearEvent = 'viewWillAppear';
        this.webViewDidAppearEvent = 'viewDidAppear';
        this.webViewWillDisappearEvent = 'viewWillDisappear';
        this.webViewDidDisappearEvent = 'viewDidDisappear';
        this.applicationEnterBackgroundEvent = 'UIApplicationDidEnterBackgroundNotification';
        this.applicationEnterForegroundEvent = 'UIApplicationWillEnterForegroundNotification';
        this.applicationBecomeActiveEvent = 'UIApplicationDidBecomeActiveNotification';
        this.applicationResignActiveEvent = 'UIApplicationWillResignActiveNotification';
    };

    var event = new CSJSNativeEvent();

    CSJSCommonHandler.prototype.registerViewWillAppear = function(callback){
        this.registerNativeCall(event.webViewWillAppearEvent,(data) => {
            //do sth
            this.nativelog(`native event call:webViewWillAppearEvent,data::${data}`);
            callback(data);
        });
    };

    CSJSCommonHandler.prototype.registerViewDidAppear = function(callback){
        this.registerNativeCall(event.webViewDidAppearEvent,(data) => {
            //do sth
            this.nativelog(`native event call:webViewDidAppearEvent,data::${data}`);
            callback(data);
        });
    };

    CSJSCommonHandler.prototype.registerViewWillDisappearEvent = function(callback){
        this.registerNativeCall(event.webViewWillDisappearEvent,(data) => {
            //do sth
            this.nativelog(`native event call:webViewWillDisappearEvent,data::${data}`);
            callback(data);
        });
    };

    CSJSCommonHandler.prototype.registerViewDidDisappear = function(callback){
        this.registerNativeCall(event.webViewDidDisappearEvent,(data) => {
            //do sth
            // jsCommonHandler.nativelog(`native event call:webViewDidDisappearEvent,data::${data}`);
            callback(data);
        });
    };

    CSJSCommonHandler.prototype.registerApplicationWillEnterForegroundNotification = function(callback){
        this.registerNativeCall(event.applicationEnterForegroundEvent,(data) => {
            //do sth
            this.nativelog(`native event call:applicationEnterForegroundEvent,data::${data}`);
            callback(data);
        });
    };

    CSJSCommonHandler.prototype.registerApplicationEnterBackgroundEvent = function(callback){
        jsCommonHandler.registerNativeCall(event.applicationEnterBackgroundEvent,(data) => {
            //do sth
             this.nativelog(`native event call:applicationEnterBackgroundEvent,data::${data}`);
             callback(data);
        });
    };

    CSJSCommonHandler.prototype.registerApplicationBecomeActiveNotification = function(callback){
        jsCommonHandler.registerNativeCall(event.applicationBecomeActiveEvent,(data) => {
            //do sth
            this.nativelog(`native event call:applicationBecomeActiveEvent,data::${data}`);
            callback(data);
        });
    };

    CSJSCommonHandler.prototype.registerApplicationResignActiveEvent = function(callback){
        jsCommonHandler.registerNativeCall(event.applicationResignActiveEvent,(data) => {
            //do sth
            this.nativelog(`native event call:applicationResignActiveEvent,data::${data}`);
            callback(data);
        });
    };
    
    var jsCommonHandler = new CSJSCommonHandler();
    window.jsCommonHandler = jsCommonHandler;

})(window);
