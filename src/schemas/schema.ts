
export interface TableList<C extends ColumnList<any>> {
	[table: string]: DatabaseTable<C>;
}

export interface ColumnList<T> {
	[column: string]: keyof T;
}

export class DatabaseSchema<T extends TableList<C>, C extends ColumnList<any>> {
	constructor(
		public readonly name: string,
		public readonly tables: T
	) { }

	toString() {
		return this.name;
	}
}

export class DatabaseTable<C extends ColumnList<any>> {
	constructor(
		public readonly name: string,
		public readonly columns: C
	) { }

	toString() {
		return this.name;
	}
}

export type Record<T, K extends keyof T, E> = E & {
	[P in K]: T[P];
}
