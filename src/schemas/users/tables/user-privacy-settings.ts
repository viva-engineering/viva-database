
import { DatabaseTable } from '../../schema';

export const userPrivacySettings = new DatabaseTable('user_privacy_settings', {
	id: 'id' as const,
	discoverableByEmail: 'discoverable_by_email' as const,
	discoverableByName: 'discoverable_by_name' as const,
	discoverableByPhone: 'discoverable_by_phone' as const,
	emailPrivacy: 'email_privacy' as const,
	phonePrivacy: 'phone_privacy' as const,
	locationPrivacy: 'location_privacy' as const,
	birthdayPrivacy: 'birthday_privacy' as const,
	defaultPostPrivacy: 'default_post_privacy' as const,
	defaultImagePrivacy: 'default_image_privacy' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
