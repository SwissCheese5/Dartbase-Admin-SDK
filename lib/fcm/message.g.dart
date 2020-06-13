// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    name: json['name'] as String,
    data: json['data'] as Map<String, dynamic>,
    notification: json['notification'] == null
        ? null
        : MessageNotification.fromJson(
            json['notification'] as Map<String, dynamic>),
    android: json['android'] == null
        ? null
        : MessageAndroidConfig.fromJson(
            json['android'] as Map<String, dynamic>),
    webpush: json['webpush'] == null
        ? null
        : MessageWebpushConfig.fromJson(
            json['webpush'] as Map<String, dynamic>),
    apns: json['apns'] == null
        ? null
        : MessageApnsConfig.fromJson(json['apns'] as Map<String, dynamic>),
    fcm_options: json['fcm_options'] == null
        ? null
        : MessageFcmOptions.fromJson(
            json['fcm_options'] as Map<String, dynamic>),
    token: json['token'] as String,
    topic: json['topic'] as String,
    condition: json['condition'] as String,
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('data', instance.data);
  writeNotNull('notification', instance.notification?.toJson());
  writeNotNull('android', instance.android?.toJson());
  writeNotNull('webpush', instance.webpush?.toJson());
  writeNotNull('apns', instance.apns?.toJson());
  writeNotNull('fcm_options', instance.fcm_options?.toJson());
  writeNotNull('token', instance.token);
  writeNotNull('topic', instance.topic);
  writeNotNull('condition', instance.condition);
  return val;
}

MessageNotification _$MessageNotificationFromJson(Map<String, dynamic> json) {
  return MessageNotification(
    title: json['title'] as String,
    body: json['body'] as String,
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$MessageNotificationToJson(MessageNotification instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('body', instance.body);
  writeNotNull('image', instance.image);
  return val;
}

MessageAndroidConfig _$MessageAndroidConfigFromJson(Map<String, dynamic> json) {
  return MessageAndroidConfig(
    collapse_key: json['collapse_key'] as String,
    priority: json['priority'] as String,
    ttl: json['ttl'] as String,
    restricted_package_name: json['restricted_package_name'] as String,
    data: json['data'] as Map<String, dynamic>,
    notification: json['notification'] == null
        ? null
        : MessageAndroidNotification.fromJson(
            json['notification'] as Map<String, dynamic>),
    fcm_options: json['fcm_options'] == null
        ? null
        : MessageAndroidFcmOptions.fromJson(
            json['fcm_options'] as Map<String, dynamic>),
    direct_boot_ok: json['direct_boot_ok'] as bool,
  );
}

Map<String, dynamic> _$MessageAndroidConfigToJson(
    MessageAndroidConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('collapse_key', instance.collapse_key);
  writeNotNull('priority', instance.priority);
  writeNotNull('ttl', instance.ttl);
  writeNotNull('restricted_package_name', instance.restricted_package_name);
  writeNotNull('data', instance.data);
  writeNotNull('notification', instance.notification);
  writeNotNull('fcm_options', instance.fcm_options);
  writeNotNull('direct_boot_ok', instance.direct_boot_ok);
  return val;
}

MessageAndroidNotification _$MessageAndroidNotificationFromJson(
    Map<String, dynamic> json) {
  return MessageAndroidNotification(
    title: json['title'] as String,
    body: json['body'] as String,
    icon: json['icon'] as String,
    color: json['color'] as String,
    sound: json['sound'] as String,
    tag: json['tag'] as String,
    click_action: json['click_action'] as String,
    body_loc_key: json['body_loc_key'] as String,
    body_loc_args:
        (json['body_loc_args'] as List)?.map((e) => e as String)?.toList(),
    title_loc_key: json['title_loc_key'] as String,
    title_loc_args:
        (json['title_loc_args'] as List)?.map((e) => e as String)?.toList(),
    channel_id: json['channel_id'] as String,
    ticker: json['ticker'] as String,
    sticky: json['sticky'] as bool,
    event_time: json['event_time'] as String,
    local_only: json['local_only'] as bool,
    notification_priority: json['notification_priority'] as String,
    default_sound: json['default_sound'] as bool,
    default_vibrate_timings: json['default_vibrate_timings'] as bool,
    default_light_settings: json['default_light_settings'] as bool,
    vibrate_timings:
        (json['vibrate_timings'] as List)?.map((e) => e as String)?.toList(),
    visibility: json['visibility'] as String,
    notification_count: json['notification_count'] as int,
    light_settings: json['light_settings'] == null
        ? null
        : MessageLightSettings.fromJson(
            json['light_settings'] as Map<String, dynamic>),
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$MessageAndroidNotificationToJson(
    MessageAndroidNotification instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('body', instance.body);
  writeNotNull('icon', instance.icon);
  writeNotNull('color', instance.color);
  writeNotNull('sound', instance.sound);
  writeNotNull('tag', instance.tag);
  writeNotNull('click_action', instance.click_action);
  writeNotNull('body_loc_key', instance.body_loc_key);
  writeNotNull('body_loc_args', instance.body_loc_args);
  writeNotNull('title_loc_key', instance.title_loc_key);
  writeNotNull('title_loc_args', instance.title_loc_args);
  writeNotNull('channel_id', instance.channel_id);
  writeNotNull('ticker', instance.ticker);
  writeNotNull('sticky', instance.sticky);
  writeNotNull('event_time', instance.event_time);
  writeNotNull('local_only', instance.local_only);
  writeNotNull('notification_priority', instance.notification_priority);
  writeNotNull('default_sound', instance.default_sound);
  writeNotNull('default_vibrate_timings', instance.default_vibrate_timings);
  writeNotNull('default_light_settings', instance.default_light_settings);
  writeNotNull('vibrate_timings', instance.vibrate_timings);
  writeNotNull('visibility', instance.visibility);
  writeNotNull('notification_count', instance.notification_count);
  writeNotNull('light_settings', instance.light_settings);
  writeNotNull('image', instance.image);
  return val;
}

MessageLightSettings _$MessageLightSettingsFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['color', 'light_on_duration', 'light_off_duration']);
  return MessageLightSettings(
    color: json['color'] == null
        ? null
        : MessageColor.fromJson(json['color'] as Map<String, dynamic>),
    light_on_duration: json['light_on_duration'] as String,
    light_off_duration: json['light_off_duration'] as String,
  );
}

Map<String, dynamic> _$MessageLightSettingsToJson(
    MessageLightSettings instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('color', instance.color);
  writeNotNull('light_on_duration', instance.light_on_duration);
  writeNotNull('light_off_duration', instance.light_off_duration);
  return val;
}

MessageColor _$MessageColorFromJson(Map<String, dynamic> json) {
  return MessageColor(
    red: (json['red'] as num)?.toDouble(),
    green: (json['green'] as num)?.toDouble(),
    blue: (json['blue'] as num)?.toDouble(),
    alpha: (json['alpha'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$MessageColorToJson(MessageColor instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('red', instance.red);
  writeNotNull('green', instance.green);
  writeNotNull('blue', instance.blue);
  writeNotNull('alpha', instance.alpha);
  return val;
}

MessageAndroidFcmOptions _$MessageAndroidFcmOptionsFromJson(
    Map<String, dynamic> json) {
  return MessageAndroidFcmOptions(
    analytics_label: json['analytics_label'] as String,
  );
}

Map<String, dynamic> _$MessageAndroidFcmOptionsToJson(
    MessageAndroidFcmOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('analytics_label', instance.analytics_label);
  return val;
}

MessageWebpushConfig _$MessageWebpushConfigFromJson(Map<String, dynamic> json) {
  return MessageWebpushConfig(
    headers: (json['headers'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    data: (json['data'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    notification: json['notification'],
    fcm_options: json['fcm_options'] == null
        ? null
        : MessageWebpushFcmOptions.fromJson(
            json['fcm_options'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MessageWebpushConfigToJson(
    MessageWebpushConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('headers', instance.headers);
  writeNotNull('data', instance.data);
  writeNotNull('notification', instance.notification);
  writeNotNull('fcm_options', instance.fcm_options);
  return val;
}

MessageWebpushFcmOptions _$MessageWebpushFcmOptionsFromJson(
    Map<String, dynamic> json) {
  return MessageWebpushFcmOptions(
    link: json['link'] as String,
    analytics_label: json['analytics_label'] as String,
  );
}

Map<String, dynamic> _$MessageWebpushFcmOptionsToJson(
    MessageWebpushFcmOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('link', instance.link);
  writeNotNull('analytics_label', instance.analytics_label);
  return val;
}

MessageApnsConfig _$MessageApnsConfigFromJson(Map<String, dynamic> json) {
  return MessageApnsConfig(
    headers: (json['headers'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    payload: json['payload'],
    fcm_options: json['fcm_options'] == null
        ? null
        : MessageApnsFcmOptions.fromJson(
            json['fcm_options'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MessageApnsConfigToJson(MessageApnsConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('headers', instance.headers);
  writeNotNull('payload', instance.payload);
  writeNotNull('fcm_options', instance.fcm_options);
  return val;
}

MessageApnsFcmOptions _$MessageApnsFcmOptionsFromJson(
    Map<String, dynamic> json) {
  return MessageApnsFcmOptions(
    analytics_label: json['analytics_label'] as String,
  )..image = json['image'] as String;
}

Map<String, dynamic> _$MessageApnsFcmOptionsToJson(
    MessageApnsFcmOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('analytics_label', instance.analytics_label);
  writeNotNull('image', instance.image);
  return val;
}

MessageFcmOptions _$MessageFcmOptionsFromJson(Map<String, dynamic> json) {
  return MessageFcmOptions(
    analytics_label: json['analytics_label'] as String,
  );
}

Map<String, dynamic> _$MessageFcmOptionsToJson(MessageFcmOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('analytics_label', instance.analytics_label);
  return val;
}

Response _$ResponseFromJson(Map<String, dynamic> json) {
  return Response(
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$ResponseToJson(Response instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  return val;
}
