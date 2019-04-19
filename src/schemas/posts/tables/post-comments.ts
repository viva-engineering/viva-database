
import { DatabaseTable } from '../../schema';

export const postComments = new DatabaseTable('post_comments', {
	id: 'id' as const,
	userId: 'user_id' as const,
	postId: 'post_id' as const,
	content: 'content' as const,
	postPrivacySettingsId : 'post_privacy_settings_id' as const,
	explicitContent: 'explicit_content' as const,
	lockExplicitContent: 'lock_explicit_content' as const,
	moderatorAccepted: 'moderator_accepted' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
