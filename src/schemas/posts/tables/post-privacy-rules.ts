
import { DatabaseTable } from '../../schema';

export const postPrivacyRules = new DatabaseTable('post_privacy_rules', {
	postPrivacySettingsId: 'post_privacy_settings_id' as const,
	appliesToUserId: 'applies_to_user_id' as const,
	appliesToGroupId: 'applies_to_group_id' as const,
	visibility: 'visibility' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
