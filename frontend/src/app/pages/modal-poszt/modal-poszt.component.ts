import { FormGroup, FormControl } from '@angular/forms';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-modal-poszt',
  templateUrl: './modal-poszt.component.html',
  styleUrls: ['./modal-poszt.component.scss']
})
export class ModalPosztComponent implements OnInit {

  form: FormGroup = new FormGroup({
    szoveg: new FormControl()
  });

  constructor() { }

  ngOnInit(): void {
  }

  addPoszt(): void {
    console.log(this.form.value);
  }

}
