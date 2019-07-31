using FluentMigrator;

[Migration(2)]
public class AddRoles : Migration
{
    public override void Up()
    {
        Create.Column("roles")
            .OnTable("users")
            .AsString(500)
            .Nullable()
            .WithDefaultValue("");
    }

    public override void Down()
    {
        Delete.Column("roles").FromTable("users");
    }
}