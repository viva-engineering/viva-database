
import { Bit, TimestampString } from '../../../types';
import { DatabaseTable, ColumnList } from '../../schema';

export interface PostPrivacyRulesColumns {
	post_privacy_settings_id: number;
	applies_to_user_id: number;
	applies_to_group_id: number;
	visibility: Bit;
	created_timestamp: TimestampString;
	updated_timestamp: TimestampString;
}

export const postPrivacyRules = new DatabaseTable('post_privacy_rules', <ColumnList<PostPrivacyRulesColumns>> {
	postPrivacySettingsId: 'post_privacy_settings_id' as const,
	appliesToUserId: 'applies_to_user_id' as const,
	appliesToGroupId: 'applies_to_group_id' as const,
	visibility: 'visibility' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
