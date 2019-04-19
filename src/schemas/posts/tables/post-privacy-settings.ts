
import { DatabaseTable } from '../../schema';

export const postPrivacySettings = new DatabaseTable('post_privacy_settings', {
	id: 'id' as const,
	userId: 'user_id' as const,
	template: 'template' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
