
import { Bit, TimestampString } from '../../../types';
import { DatabaseTable, ColumnList } from '../../schema';

export interface PostCommentsColumns {
	id: number;
	user_id: number;
	post_id: number;
	content: string;
	post_privacy_settings_id: number;
	explicit_content: Bit;
	lock_explicit_content: Bit;
	moderator_accepted: Bit;
	created_timestamp: TimestampString;
	updated_timestamp: TimestampString;
}

export const postComments = new DatabaseTable('post_comments', <ColumnList<PostCommentsColumns>> {
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
