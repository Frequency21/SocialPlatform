import { Component, Input, OnInit } from '@angular/core';
import { Poszt } from 'src/app/shared/models/poszt.model';

@Component({
  selector: 'app-poszt',
  templateUrl: './poszt.component.html',
  styleUrls: ['./poszt.component.scss']
})
export class PosztComponent implements OnInit {

  @Input() poszt!: Poszt;

  constructor() { }

  ngOnInit(): void {
  }

}
