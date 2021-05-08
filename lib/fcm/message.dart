import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'message.g.dart';

/// https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages
/// HTTP v1 protocol message
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Message {
  /// Output Only. The identifier of the message sent, in the format of
  /// projects/*/messages/{message_id}.
  final String? name;

  /// Input only. Arbitrary key/value payload. The key should not be a reserved
  /// word ("from", "message_type", or any word starting with "google" or "gcm").
  /// An object containing a list of "key": value pairs. Example:
  /// { "name": "wrench", "mass": "1.3kg", "count": "3" }.
  final Map<String, dynamic>? data;

  /// Input only. Basic notification template to use across all platforms.
  final MessageNotification? notification;

  /// Input only. Android specific options for messages sent through FCM
  /// connection server.
  final MessageAndroidConfig? android;

  /// Input only. Webpush protocol options.
  final MessageWebpushConfig? webpush;

  /// Input only. Apple Push Notification Service specific options.
  final MessageApnsConfig? apns;

  /// Input only. Template for FCM SDK feature options to use across all platforms.
  final MessageFcmOptions? fcm_options;

  /// Union field target. Required. Input only. Target to send a message to.
  /// target can be only one of the following:

  /// Registration token to send a message to.
  final String? token;

  /// Topic name to send a message to, e.g. "weather". Note: "/topics/" prefix
  /// should not be provided.
  final String? topic;

  /// Condition to send a message to, e.g. "'foo' in topics && 'bar' in topics".
  final String? condition;

  Message({
    this.name,
    this.data,
    this.notification,
    this.android,
    this.webpush,
    this.apns,
    this.fcm_options,
    this.token,
    this.topic,
    this.condition,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

/// https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages#notification
/// Basic notification template to use across all platforms.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MessageNotification {
  /// The notification's title.
  String? title;

  /// The notification's body text.
  String? body;

  /// Contains the URL of an image that is going to be downloaded on the device
  /// and displayed in a notification. JPEG, PNG, BMP have full support across
  /// platforms. Animated GIF and video only work on iOS. WebP and HEIF have
  /// varying levels of support across platforms and platform versions. Android
  /// has 1MB image size limit. Quota usage and implications/costs for hosting
  /// image on Firebase Storage: https://firebase.google.com/pricing
  String? image;

  MessageNotification({this.title, this.body, this.image});

  factory MessageNotification.fromJson(Map<String, dynamic> json) =>
      _$MessageNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$MessageNotificationToJson(this);
}

/// https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages#androidconfig
/// Android specific options for messages sent through FCM connection server.
@JsonSerializable(includeIfNull: false)
class MessageAndroidConfig {
  /// An identifier of a group of messages that can be collapsed, so that only
  /// the last message gets sent when delivery can be resumed. A maximum of 4
  /// different collapse keys is allowed at any given time.
  String? collapse_key;

  /// Message priority. Can take "normal" and "high" values. For more
  /// information, see Setting the priority of a message.
  String? priority;

  /// How long (in seconds) the message should be kept in FCM storage if the
  /// device is offline. The maximum time to live supported is 4 weeks, and the
  /// default value is 4 weeks if not set. Set it to 0 if want to send the
  /// message immediately. In JSON format, the Duration type is encoded as a
  /// string rather than an object, where the string ends in the suffix "s"
  /// (indicating seconds) and is preceded by the number of seconds, with
  /// nanoseconds expressed as fractional seconds. For example, 3 seconds with
  /// 0 nanoseconds should be encoded in JSON format as "3s", while 3 seconds
  /// and 1 nanosecond should be expressed in JSON format as "3.000000001s".
  /// The ttl will be rounded down to the nearest second.
  /// A duration in seconds with up to nine fractional digits, terminated by
  /// 's'. Example: "3.5s".
  String? ttl;

  /// Package name of the application where the registration token must match
  /// in order to receive the message.
  String? restricted_package_name;

  /// Arbitrary key/value payload. If present, it will override
  /// google.firebase.fcm.v1.Message.data.
  /// An object containing a list of "key": value pairs. Example:
  /// { "name": "wrench", "mass": "1.3kg", "count": "3" }.
  Map<String, dynamic>? data;

  /// Notification to send to android devices.
  MessageAndroidNotification? notification;

  /// Options for features provided by the FCM SDK for Android.
  MessageAndroidFcmOptions? fcm_options;

  /// If set to true, messages will be allowed to be delivered to the app while
  /// the device is in direct boot mode. See Support Direct Boot mode.
  bool? direct_boot_ok;

  MessageAndroidConfig({
    this.collapse_key,
    this.priority,
    this.ttl,
    this.restricted_package_name,
    this.data,
    this.notification,
    this.fcm_options,
    this.direct_boot_ok,
  });

  factory MessageAndroidConfig.fromJson(Map<String, dynamic> json) =>
      _$MessageAndroidConfigFromJson(json);

  Map<String, dynamic> toJson() => _$MessageAndroidConfigToJson(this);
}

/// https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages#androidnotification
/// Notification to send to android devices.
@JsonSerializable(includeIfNull: false)
class MessageAndroidNotification {
  /// The notification's title. If present, it will override
  /// google.firebase.fcm.v1.Notification.title.
  String? title;

  /// The notification's body text. If present, it will override
  /// google.firebase.fcm.v1.Notification.body.
  String? body;

  /// The notification's icon. Sets the notification icon to myicon for drawable
  /// resource myicon. If you don't send this key in the request, FCM displays
  /// the launcher icon specified in your app manifest.
  String? icon;

  /// The notification's icon color, expressed in #rrggbb format.
  String? color;

  /// The sound to play when the device receives the notification. Supports
  /// "default" or the filename of a sound resource bundled in the app. Sound
  /// files must reside in /res/raw/.
  String? sound;

  /// Identifier used to replace existing notifications in the notification
  /// drawer. If not specified, each request creates a new notification. If
  /// specified and a notification with the same tag is already being shown, the
  /// new notification replaces the existing one in the notification drawer.
  String? tag;

  /// The action associated with a user click on the notification. If specified,
  /// an activity with a matching intent filter is launched when a user clicks
  /// on the notification.
  String? click_action;

  /// The key to the body string in the app's string resources to use to
  /// localize the body text to the user's current localization. See String
  /// Resources for more information.
  String? body_loc_key;

  /// Variable string values to be used in place of the format specifiers in
  /// body_loc_key to use to localize the body text to the user's current
  /// localization. See Formatting and Styling for more information.
  List<String>? body_loc_args;

  /// The key to the title string in the app's string resources to use to
  /// localize the title text to the user's current localization. See String
  /// Resources for more information.
  String? title_loc_key;

  /// Variable string values to be used in place of the format specifiers in
  /// title_loc_key to use to localize the title text to the user's current
  /// localization. See Formatting and Styling for more information.
  List<String>? title_loc_args;

  /// The notification's channel id (new in Android O). The app must create a
  /// channel with this channel ID before any notification with this channel ID
  /// is received. If you don't send this channel ID in the request, or if the
  /// channel ID provided has not yet been created by the app, FCM uses the
  /// channel ID specified in the app manifest.
  String? channel_id;

  /// Sets the "ticker" text, which is sent to accessibility services. Prior to
  /// API level 21 (Lollipop), sets the text that is displayed in the status bar
  /// when the notification first arrives.
  String? ticker;

  /// When set to false or unset, the notification is automatically dismissed
  /// when the user clicks it in the panel. When set to true, the notification
  /// persists even when the user clicks it.
  bool? sticky;

  /// Set the time that the event in the notification occurred. Notifications in
  /// the panel are sorted by this time. A point in time is represented using
  /// protobuf.Timestamp.
  /// A timestamp in RFC3339 UTC "Zulu" format, accurate to nanoseconds.
  /// Example: "2014-10-02T15:01:23.045123456Z".
  String? event_time;

  /// Set whether or not this notification is relevant only to the current
  /// device. Some notifications can be bridged to other devices for remote
  /// display, such as a Wear OS watch. This hint can be set to recommend this
  /// notification not be bridged. See Wear OS guides
  bool? local_only;

  /// Set the relative priority for this notification. Priority is an indication
  /// of how much of the user's attention should be consumed by this
  /// notification. Low-priority notifications may be hidden from the user in
  /// certain situations, while the user might be interrupted for a
  /// higher-priority notification. The effect of setting the same priorities
  /// may differ slightly on different platforms. Note this priority differs
  /// from AndroidMessagePriority. This priority is processed by the client
  /// after the message has been delivered, whereas AndroidMessagePriority is an
  /// FCM concept that controls when the message is delivered.
  ///
  /// Possible values:
  ///   "PRIORITY_UNSPECIFIED" - If priority is unspecified, notification
  /// priority is set to
  /// `PRIORITY_DEFAULT`.
  ///   "PRIORITY_MIN" - Lowest notification priority. Notifications with
  /// this `PRIORITY_MIN`
  /// might not be shown to the user except under special
  /// circumstances,
  /// such as detailed notification logs.
  ///   "PRIORITY_LOW" - Lower notification priority. The UI may choose to
  /// show the notifications
  /// smaller, or at a different position in the list, compared
  /// with
  /// notifications with `PRIORITY_DEFAULT`.
  ///   "PRIORITY_DEFAULT" - Default notification priority. If the
  /// application does not prioritize its
  /// own notifications, use this value for all notifications.
  ///   "PRIORITY_HIGH" - Higher notification priority. Use this for more
  /// important notifications
  /// or alerts. The UI may choose to show these notifications larger, or
  /// at a
  /// different position in the notification lists, compared with
  /// notifications
  /// with `PRIORITY_DEFAULT`.
  ///   "PRIORITY_MAX" - Highest notification priority. Use this for the
  /// application's most
  /// important items that require the user's prompt attention or input.
  String? notification_priority;

  /// If set to true, use the Android framework's default sound for the
  /// notification. Default values are specified in config.xml.
  bool? default_sound;

  /// If set to true, use the Android framework's default vibrate pattern for
  /// the notification. Default values are specified in config.xml. If
  /// default_vibrate_timings is set to true and vibrate_timings is also set,
  /// the default value is used instead of the user-specified vibrate_timings.
  bool? default_vibrate_timings;

  /// If set to true, use the Android framework's default LED light settings for
  /// the notification. Default values are specified in config.xml. If
  /// default_light_settings is set to true and light_settings is also set, the
  /// user-specified light_settings is used instead of the default value.
  bool? default_light_settings;

  /// Set the vibration pattern to use. Pass in an array of protobuf.Duration to
  /// turn on or off the vibrator. The first value indicates the Duration to
  /// wait before turning the vibrator on. The next value indicates the Duration
  /// to keep the vibrator on. Subsequent values alternate between Duration to
  /// turn the vibrator off and to turn the vibrator on. If vibrate_timings is
  /// set and default_vibrate_timings is set to true, the default value is used
  /// instead of the user-specified vibrate_timings.
  ///
  /// A duration in seconds with up to nine fractional digits, terminated by
  /// 's'. Example: "3.5s".
  List<String>? vibrate_timings;

  /// Visibility: Set
  /// the
  // [Notification.visibility](https://developer.android.com/reference/
  /// android/app/Notification.html#visibility)
  /// of the notification.
  ///
  /// Possible values:
  ///   "VISIBILITY_UNSPECIFIED" - If unspecified, default to
  /// `Visibility.PRIVATE`.
  ///   "PRIVATE" - Show this notification on all lockscreens, but conceal
  /// sensitive or
  /// private information on secure lockscreens.
  ///   "PUBLIC" - Show this notification in its entirety on all
  /// lockscreens.
  ///   "SECRET" - Do not reveal any part of this notification on a secure
  /// lockscreen.
  String? visibility;

  /// Sets the number of items this notification represents. May be displayed as
  /// a badge count for launchers that support badging.See Notification Badge.
  /// For example, this might be useful if you're using just one notification to
  /// represent multiple new messages but you want the count here to represent
  /// the number of total new messages. If zero or unspecified, systems that
  /// support badging use the default, which is to increment a number displayed
  /// on the long-press menu each time a new notification arrives.
  int? notification_count;

  /// Settings to control the notification's LED blinking rate and color if LED
  /// is available on the device. The total blinking time is controlled by the
  /// OS.
  MessageLightSettings? light_settings;

  /// Contains the URL of an image that is going to be displayed in a
  /// notification. If present, it will override
  /// google.firebase.fcm.v1.Notification.image.
  String? image;

  MessageAndroidNotification({
    this.title,
    this.body,
    this.icon,
    this.color,
    this.sound,
    this.tag,
    this.click_action,
    this.body_loc_key,
    this.body_loc_args,
    this.title_loc_key,
    this.title_loc_args,
    this.channel_id,
    this.ticker,
    this.sticky,
    this.event_time,
    this.local_only,
    this.notification_priority,
    this.default_sound,
    this.default_vibrate_timings,
    this.default_light_settings,
    this.vibrate_timings,
    this.visibility,
    this.notification_count,
    this.light_settings,
    this.image,
  });

  factory MessageAndroidNotification.fromJson(Map<String, dynamic> json) =>
      _$MessageAndroidNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$MessageAndroidNotificationToJson(this);
}

/// https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages#lightsettings
/// Settings to control notification LED.
@JsonSerializable(includeIfNull: false)
class MessageLightSettings {
  /// Required. Set color of the LED with google.type.Color.
  @JsonKey(required: true)
  MessageColor? color;

  /// Required. Along with light_off_duration, define the blink rate of LED
  /// flashes. Resolution defined by proto.Duration
  ///
  /// A duration in seconds with up to nine fractional digits, terminated by
  /// 's'. Example: "3.5s".
  @JsonKey(required: true)
  String? light_on_duration;

  /// Required. Along with light_on_duration, define the blink rate of LED
  /// flashes. Resolution defined by proto.Duration
  ///
  /// A duration in seconds with up to nine fractional digits, terminated by
  /// 's'. Example: "3.5s".
  @JsonKey(required: true)
  String? light_off_duration;

  MessageLightSettings({
    @required this.color,
    @required this.light_on_duration,
    @required this.light_off_duration,
  });

  factory MessageLightSettings.fromJson(Map<String, dynamic> json) =>
      _$MessageLightSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$MessageLightSettingsToJson(this);
}

/// https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages#color
/// Represents a color in the RGBA color space.
@JsonSerializable(includeIfNull: false)
class MessageColor {
  /// The amount of red in the color as a value in the interval [0, 1].
  double? red;

  /// The amount of green in the color as a value in the interval [0, 1].
  double? green;

  /// The amount of blue in the color as a value in the interval [0, 1].
  double? blue;

  /// The fraction of this color that should be applied to the pixel. That is,
  /// the final pixel color is defined by the equation:
  ///
  /// pixel color = alpha * (this color) + (1.0 - alpha) * (background color)
  ///
  /// This means that a value of 1.0 corresponds to a solid color, whereas a
  /// value of 0.0 corresponds to a completely transparent color. This uses a
  /// wrapper message rather than a simple float scalar so that it is possible
  /// to distinguish between a default value and the value being unset. If
  /// omitted, this color object is to be rendered as a solid color (as if the
  /// alpha value had been explicitly given with a value of 1.0).
  double? alpha;

  MessageColor({
    this.red,
    this.green,
    this.blue,
    this.alpha,
  });

  factory MessageColor.fromJson(Map<String, dynamic> json) =>
      _$MessageColorFromJson(json);

  Map<String, dynamic> toJson() => _$MessageColorToJson(this);
}

/// https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages#androidfcmoptions
/// Options for features provided by the FCM SDK for Android.
@JsonSerializable(includeIfNull: false)
class MessageAndroidFcmOptions {
  /// Label associated with the message's analytics data.
  String? analytics_label;

  MessageAndroidFcmOptions({
    this.analytics_label,
  });

  factory MessageAndroidFcmOptions.fromJson(Map<String, dynamic> json) =>
      _$MessageAndroidFcmOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$MessageAndroidFcmOptionsToJson(this);
}

/// https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages#webpushconfig
/// Webpush protocol options.
@JsonSerializable(includeIfNull: false)
class MessageWebpushConfig {
  /// HTTP headers defined in webpush protocol. Refer to Webpush protocol for
  /// supported headers, e.g. "TTL": "15".
  ///
  /// An object containing a list of "key": value pairs. Example:
  /// { "name": "wrench", "mass": "1.3kg", "count": "3" }.
  Map<String, String>? headers;

  /// Arbitrary key/value payload. If present, it will override
  /// google.firebase.fcm.v1.Message.data.
  ///
  /// An object containing a list of "key": value pairs. Example:
  /// { "name": "wrench", "mass": "1.3kg", "count": "3" }.
  Map<String, String>? data;

  /// Web Notification options as a JSON object. Supports Notification instance
  /// properties as defined in Web Notification API. If present, "title" and
  /// "body" fields override google.firebase.fcm.v1.Notification.title and
  /// google.firebase.fcm.v1.Notification.body.
  Object? notification;

  /// Options for features provided by the FCM SDK for Web.
  MessageWebpushFcmOptions? fcm_options;

  MessageWebpushConfig({
    this.headers,
    this.data,
    this.notification,
    this.fcm_options,
  });

  factory MessageWebpushConfig.fromJson(Map<String, dynamic> json) =>
      _$MessageWebpushConfigFromJson(json);

  Map<String, dynamic> toJson() => _$MessageWebpushConfigToJson(this);
}

/// https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages#webpushfcmoptions
/// Options for features provided by the FCM SDK for Web.
@JsonSerializable(includeIfNull: false)
class MessageWebpushFcmOptions {
  /// The link to open when the user clicks on the notification. For all URL
  /// values, HTTPS is required.
  String? link;

  /// Label associated with the message's analytics data.
  String? analytics_label;

  MessageWebpushFcmOptions({
    this.link,
    this.analytics_label,
  });

  factory MessageWebpushFcmOptions.fromJson(Map<String, dynamic> json) =>
      _$MessageWebpushFcmOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$MessageWebpushFcmOptionsToJson(this);
}

/// https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages#apnsconfig
/// Apple Push Notification Service specific options.
@JsonSerializable(includeIfNull: false)
class MessageApnsConfig {
  /// HTTP request headers defined in Apple Push Notification Service. Refer to
  /// APNs request headers for supported headers, e.g. "apns-priority": "10".
  ///
  /// An object containing a list of "key": value pairs.
  /// Example: { "name": "wrench", "mass": "1.3kg", "count": "3" }.
  Map<String, String>? headers;

  /// AHTTP request headers defined in Apple Push Notification Service. Refer to
  /// APNs request headers for supported headers, e.g. "apns-priority": "10".
  ///
  /// An object containing a list of "key": value pairs. Example:
  /// { "name": "wrench", "mass": "1.3kg", "count": "3" }.
  Object? payload;

  /// Options for features provided by the FCM SDK for iOS.
  MessageApnsFcmOptions? fcm_options;

  MessageApnsConfig({
    this.headers,
    this.payload,
    this.fcm_options,
  });

  factory MessageApnsConfig.fromJson(Map<String, dynamic> json) =>
      _$MessageApnsConfigFromJson(json);

  Map<String, dynamic> toJson() => _$MessageApnsConfigToJson(this);
}

/// https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages#apnsfcmoptions
/// Options for features provided by the FCM SDK for iOS.
@JsonSerializable(includeIfNull: false)
class MessageApnsFcmOptions {
  /// Label associated with the message's analytics data.
  String? analytics_label;

  /// Contains the URL of an image that is going to be displayed in a
  /// notification. If present, it will override
  /// google.firebase.fcm.v1.Notification.image.
  String? image;

  MessageApnsFcmOptions({
    this.analytics_label,
  });

  factory MessageApnsFcmOptions.fromJson(Map<String, dynamic> json) =>
      _$MessageApnsFcmOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$MessageApnsFcmOptionsToJson(this);
}

/// https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages#fcmoptions
/// Platform independent options for features provided by the FCM SDKs.
@JsonSerializable(includeIfNull: false)
class MessageFcmOptions {
  /// Label associated with the message's analytics data.
  String? analytics_label;

  MessageFcmOptions({
    this.analytics_label,
  });

  factory MessageFcmOptions.fromJson(Map<String, dynamic> json) =>
      _$MessageFcmOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$MessageFcmOptionsToJson(this);
}

/// https://firebase.google.com/docs/reference/fcm/rest/v1/FcmError
/// Message that may be returned in an error response to add details.
class FcmError implements Exception {
  /// Error code specifying why the message failed.
  /// https://firebase.google.com/docs/reference/fcm/rest/v1/ErrorCode
  String error_code;

  FcmError(this.error_code);

  @override
  String toString() {
    return 'error_code: $error_code';
  }
}

/// https://firebase.google.com/docs/reference/fcm/rest/v1/ApnsError
/// Error details directly from the Apple Push Notification service (APNs).
class ApnsError implements Exception {
  /// Status code in the response from APNs. See APNs status codes for
  /// explanations of possible values.
  /// https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CommunicatingwithAPNs.html#//apple_ref/doc/uid/TP40008194-CH11-SW15
  int status_code;

  /// Failure reason in the response from APNs. See values for explanations of
  /// possible values.
  /// https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CommunicatingwithAPNs.html#//apple_ref/doc/uid/TP40008194-CH11-SW17
  String reason;

  ApnsError(this.status_code, this.reason);
}

@JsonSerializable(includeIfNull: false)
class Response {
  String? name;

  Response({this.name});

  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}
