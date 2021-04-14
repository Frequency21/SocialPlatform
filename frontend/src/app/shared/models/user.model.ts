export interface User {
    id: number;
    jelszo: string;
    email: string;
    vnev: string;
    knev: string;
    csatl: string;
    szul_dat: Date;
    munka_iskola?: string;
    picture?: Blob;
    isAdmin: Boolean;
}