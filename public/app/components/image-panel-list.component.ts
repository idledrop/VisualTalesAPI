import {Component, OnInit} from 'angular2/core';

@Component({
    selector: 'image-panel-list',
    templateUrl: 'app/components/image-panel-list.component.html',
    styleUrls: ['app/components/image-panel-list.component.css'],
    inputs: ['list', 'options', 'panelClick']
})

export class ImagePanelListComponent implements OnInit {
  list:any[];
  options:IImagePanelList;
  panelClick:(listItem:any)=>void;
  
  panelTitle:string;
  panelClass:string;
  
  constructor() { }

  ngOnInit() {
    this.panelTitle = this.options.panelTitle || 'title';
    this.panelClass = this.calculatePanelClass(this.options);
  }
  
  selectItem(listItem:any) {
    if (this.panelClick) {
      this.panelClick(listItem);
    }
  };
  
  private calculatePanelClass({panelsPerLine, panelsPerLineMd=3, panelsPerLineSm=1}) {
      let panelClass = this.getPanelColumnClass(panelsPerLine);
      panelClass += ' ' + this.getPanelColumnClass(panelsPerLineMd, 'md');
      panelClass += ' ' + this.getPanelColumnClass(panelsPerLineSm, 'sm');
      
      return panelClass;
  };
  
  private getPanelColumnClass (panelsPerLine:number, columnClass:string='lg') {
      let columnSize = Math.floor(12 / panelsPerLine);
      columnSize = columnSize > 12 ? 12 : columnSize;
      return "col-" + columnClass + "-" + columnSize;
  };
}

export interface IImagePanelList{
  panelTitle?:string;
  imageUrl?:string;
  panelsPerLine:number;
  panelsPerLineMd?:number;
  panelsPerLineSm?:number;
}