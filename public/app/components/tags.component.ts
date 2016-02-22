import {Component} from 'angular2/core';
import {TagService, ITag} from '../data/tag.service'

@Component({
    selector: 'tags',
    inputs: ['tags'],
    template: `
                <div class="chip" *ngFor="#tag of tags">
                    {{tag.name}}
                    <span class="close-btn" (click)="delete(tag.id)">&times;</span>
                </div>
                <div class="add-chip">
                    <input type="text" (focus)="onFocus()" #newTagControl (keyup)="autoGrow(newTagControl)" (keyup.enter)="add(newTagControl)" placeholder="Add Tag" />
                    <span class="close-btn" *ngIf="isNewTagFocused" (click)="newTagCancel(newTagControl)">&times;</span>

                </div>
              `,
    styleUrls: ['app/tags.component.css']
})
export class TagsComponent {
    public tags: any[] = [];
    isNewTagFocused: boolean = false;
    newTagDefaultWidth: number = 50;

    public constructor(private _tagService: TagService) {
    }
    
    public delete(id: number) {
        function findByIdFilter(tag) {
            if (tag.id === id) {
                return false;
            } else {
                return true;
            }
        }
        this.tags = this.tags.filter(findByIdFilter);
    }

    public autoGrow(newTagControl) {
        var baseCount: number = 4;
        var increaseBy: number = 8;
        var width: number = this.newTagDefaultWidth + (newTagControl.value.length - baseCount < 0 ? 0 : newTagControl.value.length - baseCount) * increaseBy;
        newTagControl.style = "width: " + width +"px";
    }

    public onFocus() {
        this.isNewTagFocused = true;
    }

    public newTagCancel(newTagControl) {
        this.resetNewTag(newTagControl);
    }

    public add(newTagControl) {
        this._tagService.createTag(<ITag>{ name: newTagControl.value })
            .subscribe(
                tag => this.tags = this.tags.concat([tag])
            );
        this.resetNewTag(newTagControl);
    }

    private resetNewTag(newTagControl) {
        newTagControl.value = "";
        newTagControl.blur();
        newTagControl.style = "width: " + this.newTagDefaultWidth + "px";
        this.isNewTagFocused = false;
    }
}