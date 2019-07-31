using FluentMigrator;

[Migration(1)]
public class CreateUser : Migration
{
    public override void Up()
    {
        Create.Table("users")
            .WithColumn("identifier").AsString(50).PrimaryKey().NotNullable()
            .WithColumn("license").AsString(50).NotNullable()
            .WithColumn("bank").AsInt32().NotNullable().WithDefaultValue(-1)
            .WithColumn("permission_level").AsInt32().NotNullable().WithDefaultValue(0)
            .WithColumn("money").AsInt32().NotNullable().WithDefaultValue(0)
            .WithColumn("group").AsString(500).NotNullable();
    }

    public override void Down()
    {
        Delete.Table("users");
    }
}