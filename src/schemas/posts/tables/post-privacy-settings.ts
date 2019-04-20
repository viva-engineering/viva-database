
import { TimestampString } from '../../../types';
import { DatabaseTable, ColumnList } from '../../schema';

export interface PostPrivacySettingsColumns {
	id: number;
	user_id: number;
	template: string;
	created_timestamp: TimestampString;
	updated_timestamp: TimestampString;
}

export const postPrivacySettings = new DatabaseTable('post_privacy_settings', {
	id: 'id' as const,
	userId: 'user_id' as const,
	template: 'template' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
