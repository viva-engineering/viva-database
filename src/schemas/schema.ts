
export interface TableList<C extends ColumnList> {
	[table: string]: DatabaseTable<C>;
}

export interface ColumnList {
	[column: string]: string;
}

export class DatabaseSchema<T extends TableList<C>, C extends ColumnList> {
	constructor(
		public readonly name: string,
		public readonly tables: T
	) { }
}

export class DatabaseTable<C extends ColumnList> {
	constructor(
		public readonly name: string,
		public readonly columns: C
	) { }
}
