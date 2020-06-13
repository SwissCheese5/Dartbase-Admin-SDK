// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

V1Message _$V1MessageFromJson(Map<String, dynamic> json) {
  return V1Message(
    name: json['name'] as String,
    data: json['data'] as Map<String, dynamic>,
    notification: json['notification'] == null
        ? null
        : V1MessageNotification.fromJson(
            json['notification'] as Map<String, dynamic>),
    android: json['android'] == null
        ? null
        : V1MessageAndroidConfig.fromJson(
            json['android'] as Map<String, dynamic>),
    webpush: json['webpush'] == null
        ? null
        : V1MessageWebpushConfig.fromJson(
            json['webpush'] as Map<String, dynamic>),
    apns: json['apns'] == null
        ? null
        : V1MessageApnsConfig.fromJson(json['apns'] as Map<String, dynamic>),
    fcm_options: json['fcm_options'] == null
        ? null
        : V1MessageFcmOptions.fromJson(
            json['fcm_options'] as Map<String, dynamic>),
    token: json['token'] as String,
    topic: json['topic'] as String,
    condition: json['condition'] as String,
  );
}

Map<String, dynamic> _$V1MessageToJson(V1Message instance) {
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

V1MessageNotification _$V1MessageNotificationFromJson(
    Map<String, dynamic> json) {
  return V1MessageNotification(
    title: json['title'] as String,
    body: json['body'] as String,
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$V1MessageNotificationToJson(
    V1MessageNotification instance) {
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

V1MessageAndroidConfig _$V1MessageAndroidConfigFromJson(
    Map<String, dynamic> json) {
  return V1MessageAndroidConfig(
    collapse_key: json['collapse_key'] as String,
    priority: json['priority'] as String,
    ttl: json['ttl'] as String,
    restricted_package_name: json['restricted_package_name'] as String,
    data: json['data'] as Map<String, dynamic>,
    notification: json['notification'] == null
        ? null
        : V1MessageAndroidNotification.fromJson(
            json['notification'] as Map<String, dynamic>),
    fcm_options: json['fcm_options'] == null
        ? null
        : V1MessageAndroidFcmOptions.fromJson(
            json['fcm_options'] as Map<String, dynamic>),
    direct_boot_ok: json['direct_boot_ok'] as bool,
  );
}

Map<String, dynamic> _$V1MessageAndroidConfigToJson(
    V1MessageAndroidConfig instance) {
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

V1MessageAndroidNotification _$V1MessageAndroidNotificationFromJson(
    Map<String, dynamic> json) {
  return V1MessageAndroidNotification(
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
        : V1MessageLightSettings.fromJson(
            json['light_settings'] as Map<String, dynamic>),
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$V1MessageAndroidNotificationToJson(
    V1MessageAndroidNotification instance) {
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

V1MessageLightSettings _$V1MessageLightSettingsFromJson(
    Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['color', 'light_on_duration', 'light_off_duration']);
  return V1MessageLightSettings(
    color: json['color'] == null
        ? null
        : V1MessageColor.fromJson(json['color'] as Map<String, dynamic>),
    light_on_duration: json['light_on_duration'] as String,
    light_off_duration: json['light_off_duration'] as String,
  );
}

Map<String, dynamic> _$V1MessageLightSettingsToJson(
    V1MessageLightSettings instance) {
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

V1MessageColor _$V1MessageColorFromJson(Map<String, dynamic> json) {
  return V1MessageColor(
    red: (json['red'] as num)?.toDouble(),
    green: (json['green'] as num)?.toDouble(),
    blue: (json['blue'] as num)?.toDouble(),
    alpha: (json['alpha'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$V1MessageColorToJson(V1MessageColor instance) {
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

V1MessageAndroidFcmOptions _$V1MessageAndroidFcmOptionsFromJson(
    Map<String, dynamic> json) {
  return V1MessageAndroidFcmOptions(
    analytics_label: json['analytics_label'] as String,
  );
}

Map<String, dynamic> _$V1MessageAndroidFcmOptionsToJson(
    V1MessageAndroidFcmOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('analytics_label', instance.analytics_label);
  return val;
}

V1MessageWebpushConfig _$V1MessageWebpushConfigFromJson(
    Map<String, dynamic> json) {
  return V1MessageWebpushConfig(
    headers: (json['headers'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    data: (json['data'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    notification: json['notification'],
    fcm_options: json['fcm_options'] == null
        ? null
        : V1MessageWebpushFcmOptions.fromJson(
            json['fcm_options'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$V1MessageWebpushConfigToJson(
    V1MessageWebpushConfig instance) {
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

V1MessageWebpushFcmOptions _$V1MessageWebpushFcmOptionsFromJson(
    Map<String, dynamic> json) {
  return V1MessageWebpushFcmOptions(
    link: json['link'] as String,
    analytics_label: json['analytics_label'] as String,
  );
}

Map<String, dynamic> _$V1MessageWebpushFcmOptionsToJson(
    V1MessageWebpushFcmOptions instance) {
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

V1MessageApnsConfig _$V1MessageApnsConfigFromJson(Map<String, dynamic> json) {
  return V1MessageApnsConfig(
    headers: (json['headers'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    payload: json['payload'],
    fcm_options: json['fcm_options'] == null
        ? null
        : V1MessageApnsFcmOptions.fromJson(
            json['fcm_options'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$V1MessageApnsConfigToJson(V1MessageApnsConfig instance) {
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

V1MessageApnsFcmOptions _$V1MessageApnsFcmOptionsFromJson(
    Map<String, dynamic> json) {
  return V1MessageApnsFcmOptions(
    analytics_label: json['analytics_label'] as String,
  )..image = json['image'] as String;
}

Map<String, dynamic> _$V1MessageApnsFcmOptionsToJson(
    V1MessageApnsFcmOptions instance) {
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

V1MessageFcmOptions _$V1MessageFcmOptionsFromJson(Map<String, dynamic> json) {
  return V1MessageFcmOptions(
    analytics_label: json['analytics_label'] as String,
  );
}

Map<String, dynamic> _$V1MessageFcmOptionsToJson(V1MessageFcmOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('analytics_label', instance.analytics_label);
  return val;
}

V1Response _$V1ResponseFromJson(Map<String, dynamic> json) {
  return V1Response(
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$V1ResponseToJson(V1Response instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  return val;
}
