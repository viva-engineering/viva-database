
import { DatabaseSchema } from '../schema';

import { applications } from './tables/applications';
import { credentials } from './tables/credentials';
import { friends } from './tables/friends';
import { moderatorNotes } from './tables/moderator-notes';
import { pagesFollows } from './tables/page-follows';
import { pages } from './tables/pages';
import { sessions } from './tables/sessions';
import { userApplications } from './tables/user-applications';
import { userGroupUsers } from './tables/user-group-users';
import { userGroups } from './tables/user-groups';
import { userPrivacySettings } from './tables/user-privacy-settings';
import { userRoles } from './tables/user-roles';
import { users } from './tables/users';

export { UserRoles } from './tables/user-roles';

export const usersSchema = new DatabaseSchema('viva_users', {
	applications,
	credentials,
	friends,
	moderatorNotes,
	pagesFollows,
	pages,
	sessions,
	userApplications,
	userGroupUsers,
	userGroups,
	userPrivacySettings,
	userRoles,
	users
});
