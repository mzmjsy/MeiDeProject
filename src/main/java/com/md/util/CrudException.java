package com.md.util;

/**
 * @author mz
 */
public class CrudException extends Exception {
    private static final long serialVersionUID = 4570573798200354363L;

    public CrudException(String msg) {
        super(msg);
    }

    public CrudException(Throwable cause) {
        super(cause);
    }

    public CrudException(String msg, Throwable cause) {
        super(msg, cause);
    }
}
