
import { DatabaseSchema } from '../schema';

import { flaggedPostComments } from './tables/flagged-post-comments';
import { flaggedPosts } from './tables/flagged-posts';
import { postComments } from './tables/post-comments';
import { posts } from './tables/posts';
import { postPrivacySettings } from './tables/post-privacy-settings';
import { postPrivacyRules } from './tables/post-privacy-rules';

export const postsSchema = new DatabaseSchema('viva_posts', {
	flaggedPostComments,
	flaggedPosts,
	postComments,
	posts,
	postPrivacySettings,
	postPrivacyRules
});
