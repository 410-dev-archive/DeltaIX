package org.mcmasterkboys.codenamehenryford.objects.posts;

import lombok.Getter;
import lombok.Setter;
import me.hy.libhycore.CoreDate;
import me.hy.libhyextended.objects.DatabaseObject;
import me.hy.libhyextended.objects.exception.DataFieldMismatchException;
import org.mcmasterkboys.codenamehenryford.modules.SQLConnectionFactory;

import java.sql.SQLException;

@Getter
@Setter
public class Board extends DatabaseObject {

    private String uuid;
    private String name;
    private String description;
    private String categoryUUID;
    private long lastUpdated;

    private String tableName = "board";
    private String pkName = "uuid";
    private String pkType = "String";

    public Board() {
        super(SQLConnectionFactory.class);
    }

    public Board(String uuid, String name, String description, String categoryUUID) {
        super(SQLConnectionFactory.class);
        this.uuid = uuid;
        this.name = name;
        this.description = description;
        this.categoryUUID = categoryUUID;
        this.lastUpdated = CoreDate.mSecSince1970();
    }

    public Board(String boardUUID) throws SQLException, DataFieldMismatchException {
        super(SQLConnectionFactory.class);
        this.uuid = boardUUID;
        super.setPkValue(boardUUID);
        this.select();
    }
}
