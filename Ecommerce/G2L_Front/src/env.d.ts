declare namespace NodeJS {
    interface ProcessEnv {
        VUE_ROUTER_MODE: 'hash' | 'history' | 'abstract' | undefined;
        VUE_ROUTER_BASE: string | undefined;
        API_URL: string,
        API_ACCESS_URL: string,
        API_EMAIL: string
    }
}
