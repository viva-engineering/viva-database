
import { DatabaseTable } from '../../schema';

export const posts = new DatabaseTable('posts', {
	id: 'id' as const,
	userId: 'user_id' as const,
	pageId: 'page_id' as const,
	content: 'content' as const,
	postPrivacySettingsId : 'post_privacy_settings_id' as const,
	explicitContent: 'explicit_content' as const,
	lockExplicitContent: 'lock_explicit_content' as const,
	moderatorAccepted: 'moderator_accepted' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
