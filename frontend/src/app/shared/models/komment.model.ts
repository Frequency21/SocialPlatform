import { Ertekeles } from './ertekeles.model';
export interface Komment {
  idopont: string;
  komment_iro_id: number;
  poszt_id: number;
  szoveg: string;
  ertekeles: Ertekeles;
  isPublic: boolean;
}
