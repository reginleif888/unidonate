<script lang="ts">
  import { DatePicker } from "bits-ui";
  import { CaretLeft, CaretRight, CalendarBlank } from "phosphor-svelte";
  import { flyAndScale } from "../transitions";
  import { type DateValue } from "@internationalized/date";

  type $$Props = {
    value: DateValue | null;
    error?: boolean;
  };

  export let value: any = null;
  export let error: boolean = false;
</script>

<DatePicker.Root
  weekdayFormat="short"
  fixedWeeks={true}
  bind:value
  locale={window.navigator.language}
>
  <div class="date-picker-root__inner input-text-medium">
    <DatePicker.Input
      let:segments
      class={`date-picker-root__input ${error ? "date-picker-root__input--error" : ""}`}
    >
      {#each segments as { part, value }}
        <div class="date-picker-root__segment-wrapper">
          {#if part === "literal"}
            <DatePicker.Segment {part} class="date-picker-root__segment-first">
              {value}
            </DatePicker.Segment>
          {:else}
            <DatePicker.Segment {part} class="date-picker-root__segment-second">
              {value}
            </DatePicker.Segment>
          {/if}
        </div>
      {/each}
      <DatePicker.Trigger class="date-picker-root__trigger">
        <CalendarBlank size={24} />
      </DatePicker.Trigger>
    </DatePicker.Input>
    <div></div>

    <DatePicker.Content
      sideOffset={6}
      transition={flyAndScale}
      transitionConfig={{ duration: 150, y: -8 }}
      class="date-picker-root__content"
    >
      <DatePicker.Calendar
        class="date-picker-root__calendar"
        let:months
        let:weekdays
      >
        <DatePicker.Header class="date-picker-root__header">
          <DatePicker.PrevButton class="date-picker-root__header-button">
            <CaretLeft size={24} />
          </DatePicker.PrevButton>
          <DatePicker.Heading class="subtitle1" />
          <DatePicker.NextButton class="date-picker-root__header-button">
            <CaretRight size={24} />
          </DatePicker.NextButton>
        </DatePicker.Header>
        <div class="date-picker-root__grid-wrapper">
          {#each months as month}
            <DatePicker.Grid class="date-picker-root__grid">
              <DatePicker.GridHead>
                <DatePicker.GridRow class="data-picker-root__grid-row">
                  {#each weekdays as day}
                    <DatePicker.HeadCell
                      class="date-picker-root__grid-head-cell"
                    >
                      <div>{day.slice(0, 2)}</div>
                    </DatePicker.HeadCell>
                  {/each}
                </DatePicker.GridRow>
              </DatePicker.GridHead>
              <DatePicker.GridBody>
                {#each month.weeks as weekDates}
                  <DatePicker.GridRow class="date-picker-root__grid-dates-row">
                    {#each weekDates as date}
                      <DatePicker.Cell
                        {date}
                        class="date-picker-root__grid-day-cell"
                      >
                        <DatePicker.Day
                          {date}
                          month={month.value}
                          class="date-picker-root__grid-day"
                        >
                          <div
                            class="absolute top-[5px] hidden size-1 rounded-full bg-foreground transition-all group-data-[today]:block group-data-[selected]:bg-background"
                          />
                          {date.day}
                        </DatePicker.Day>
                      </DatePicker.Cell>
                    {/each}
                  </DatePicker.GridRow>
                {/each}
              </DatePicker.GridBody>
            </DatePicker.Grid>
          {/each}
        </div>
      </DatePicker.Calendar>
    </DatePicker.Content>
  </div>
</DatePicker.Root>

<style>
  :global(.date-picker-root) {
    display: flex;
    flex-direction: column;
    gap: 6px;
    width: 100%;
  }

  :global(.date-picker-root__input) {
    user-select: none;
    display: flex;
    align-items: center;
    gap: 8px;
    background-color: var(--uni-input-bg);
    border-radius: var(--uni-radius-input);
    border: 1px solid;
    border-color: var(--uni-input-border);
    width: 100%;
    padding: var(--uni-padding-input-medium);
    height: var(--uni-height-input-medium);
  }

  :global(.date-picker-root__input--error) {
    border-color: var(--uni-input-border-error);
    color: var(--uni-input-color-error);
    background-color: var(--uni-input-bg-error);
  }

  :global(.date-picker-root__input:focus-within) {
    outline: 2px solid var(--uni-focus-outline);
    border-color: var(--uni-input-border);
  }

  :global(.date-picker-root__segment-wrapper) {
    display: inline-block;
    user-select: none;
  }

  :global(.date-picker-root__inner) {
    display: flex;
    flex-direction: column;
    gap: 6px;
    width: 100%;
  }

  :global(.date-picker-root__segment-first) {
    padding: 4px;
    color: var(--uni-text-color-600);
  }

  :global(.date-picker-root__segment-second) {
    padding: 4px;
  }

  :global(.date-picker-root__segment-second[aria-valuetext="Empty"]) {
    color: var(--uni-text-color-600);
  }

  :global(.date-picker-root__segment-second:focus) {
    outline: unset;
    border: unset;
    background-color: var(--uni-primary-transparent-10);
    border-radius: 4px;
  }

  :global(.date-picker-root__trigger) {
    display: inline-flex;
    justify-content: center;
    align-items: center;
    margin-left: auto;
    background-color: transparent;
    color: var(--uni-on-bg);
    cursor: pointer;
    border: unset;
  }

  :global(.date-picker-root__trigger:focus) {
    outline: unset;
    border: unset;
    background-color: var(--uni-primary-transparent-10);
    border-radius: 4px;
  }

  :global(.date-picker-root__content) {
    z-index: 50;
  }

  :global(.date-picker-root__calendar) {
    border-radius: 16px;
    border: 1px solid var(--uni-divider-color);
    padding: 20px;
    box-shadow: var(--uni-shadow-paper);
    background-color: var(--uni-bg);
  }

  :global(.date-picker-root__header) {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  :global(.date-picker-root__header-button) {
    display: inline-flex;
    justify-content: center;
    align-items: center;
    border-radius: 9px;
    background-color: var(--uni-bg);
    color: var(--uni-on-bg);
    transition: all 0.2s;
    cursor: pointer;
    border: unset;
    height: 40px;
    width: 40px;
  }

  :global(.date-picker-root__header-button:focus) {
    outline: unset;
  }

  :global(.date-picker-root__header-button:hover) {
    background-color: var(--uni-primary-transparent-10);
  }

  :global(.date-picker-root__grid-wrapper) {
    display: flex;
    padding-top: 16px;
    margin-top: 16px;
    flex-direction: column;
  }

  @media (min-width: 640px) {
    :global(.date-picker-root__grid-wrapper) {
      margin-top: 0;
      flex-direction: row;
    }
  }

  :global(.date-picker-root__grid) {
    margin-top: 4px;
    width: 100%;
    user-select: none;
    border-collapse: collapse;
  }

  :global(.data-picker-root__grid-row) {
    display: flex;
    margin-bottom: 4px;
    justify-content: space-between;
    width: 100%;
  }

  :global(.date-picker-root__grid-head-cell) {
    width: 40px;
    text-align: center;
    padding: 4px;
    border-radius: 6px;
    font-size: 12px;
    line-height: 16px;
    color: var(--uni-text-color-600);
  }

  :global(.date-picker-root__grid-dates-row) {
    display: flex;
    width: 100%;
  }

  :global(.date-picker-root__grid-day-cell) {
    position: relative;
    font-size: 14px;
    line-height: 20px;
    text-align: center;
    width: 40px;
    height: 40px;
  }

  :global(.date-picker-root__grid-day) {
    display: inline-flex;
    position: relative;
    padding: 0;
    justify-content: center;
    align-items: center;
    border-radius: 4px;
    border-color: transparent;
    font-size: 14px;
    line-height: 20px;
    font-weight: 400;
    width: 40px;
    height: 40px;
    white-space: nowrap;
    background-color: transparent;
    cursor: pointer;
  }

  :global(.date-picker-root__grid-day:hover) {
    border: 1px solid var(--uni-divider-color);
  }

  :global(.date-picker-root__grid-day:focus) {
    outline: unset;
    border: 1px solid var(--uni-primary);
  }

  :global(.date-picker-root__grid-day[data-disabled]) {
    color: var(--uni-text-color-600);
    pointer-events: none;
  }

  :global(.date-picker-root__grid-day[data-selected]) {
    background-color: var(--uni-primary);
    color: var(--uni-on-primary);
    font-weight: 500;
  }
</style>
