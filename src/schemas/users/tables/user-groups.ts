
import { TimestampString } from '../../../types';
import { DatabaseTable, ColumnList } from '../../schema';

export interface UserGroupsColumns {
	id: number;
	user_id: number;
	name: string;
	created_timestamp: TimestampString;
	updated_timestamp: TimestampString;
}

export const userGroups = new DatabaseTable('user_groups', <ColumnList<UserGroupsColumns>> {
	id: 'id' as const,
	userId: 'user_id' as const,
	name: 'name' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
