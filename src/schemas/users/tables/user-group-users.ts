
import { TimestampString } from '../../../types';
import { DatabaseTable, ColumnList } from '../../schema';

export interface UserGroupUsersColumns {
	user_group_id: number;
	user_id: number;
	created_timestamp: TimestampString;
	updated_timestamp: TimestampString;
}

export const userGroupUsers = new DatabaseTable('user_group_users', <ColumnList<UserGroupUsersColumns>> {
	userGroupId: 'user_group_id' as const,
	userId: 'user_id' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
