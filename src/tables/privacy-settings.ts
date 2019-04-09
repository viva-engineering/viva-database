
export const privacySettingsTable = Object.freeze({
	name: 'user_privacy_settings',
	columns: {
		id: 'id',
		discoverableByEmail: 'discoverable_by_email',
		discoverableByName: 'discoverable_by_name',
		discoverableByPhone: 'discoverable_by_phone',
		emailPrivacy: 'email_privacy',
		phonePrivacy: 'phone_privacy',
		locationPrivacy: 'location_privacy',
		birthdayPrivacy: 'birthday_privacy',
		defaultPostPrivacy: 'default_post_privacy',
		defaultImagePrivacy: 'default_image_privacy',
		createdTimestamp: 'created_timestamp',
		updatedTimestamp: 'updated_timestamp'
	}
});
