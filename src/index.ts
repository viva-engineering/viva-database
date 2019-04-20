
import { DatabasePool } from '@viva-eng/database';
import { i18nSchema } from './schemas/i18n';
import { postsSchema } from './schemas/posts';
import { usersSchema } from './schemas/users';
// import { notificationsSchema } from './schemas/notifications';

export { SelectQuery, WriteQuery } from './queries';
export { Bit, PrivacyFlag, VisibilityFlag, DateString, TimestampString, UserRole } from './types';
export { TableList, ColumnList, DatabaseSchema, DatabaseTable, Record } from './schemas/schema';
export {
	I18nComponentsColumns,
	I18nLabelsColumns,
	I18nTranslationsColumns,
	I18nLanguagesColumns,
	ApplicationsColumns,
	CredentialsColumns,
	FriendsColumns,
	ModeratorNotesColumns,
	PageFollowsColumns,
	PagesColumns,
	SessionsColumns,
	UserApplicationsColumns,
	UserGroupUsersColumns,
	UserGroupsColumns,
	UserPrivacySettingsColumns,
	UserRolesColumns,
	UsersColumns,
	FlaggedPostCommentsColumns,
	FlaggedPostsColumns,
	PostCommentsColumns,
	PostPrivacyRulesColumns,
	PostPrivacySettingsColumns,
	PostsColumns
} from './column-types';

export const schemas = {
	i18n: i18nSchema,
	posts: postsSchema,
	users: usersSchema,
	// notifications: notificationsSchema
};

export let db: DatabasePool;

export const init = (params) => {
	db = new DatabasePool(params);
};
