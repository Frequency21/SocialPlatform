import { Component, OnInit } from '@angular/core';
import { PosztService } from 'src/app/services/poszt.service';
import { Poszt } from 'src/app/shared/models/poszt.model';

@Component({
  selector: 'app-display-posts',
  templateUrl: './display-posts.component.html',
  styleUrls: ['./display-posts.component.scss']
})
export class DisplayPostsComponent implements OnInit {

  poszts?: Poszt[];

  constructor(private posztService: PosztService) { }

  ngOnInit(): void {
    this.getPoszts();
  }

  getPoszts(): void {
    this.posztService.getPoszts().subscribe(poszts => {
      this.poszts = poszts;
      console.log(poszts);
      console.log(this.poszts);
    });
  }

  openDialog(): void {
    console.log("cry");
  }

}
